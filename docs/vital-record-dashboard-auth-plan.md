# Vital Records Dashboard Authentication Plan

## Current State

`GET /getClientVitalRecords?clientId=<id>` and `GET /getClientVitalRecordsByDate` accept either a valid admin token or a legacy shared `PassToken`. The date-range endpoint can return records for all clients in the requested date range. Create, update, and retrieve actions remain admin-only. Shared-token access is a temporary compatibility measure for the dashboard.

`GET /getClientVitalRecordsByDate` requires `fromDate` and `toDate` in `YYYY-MM-DD` format, filters by `entered_on`, and returns cursor-paginated results (100 records by default, maximum 500). Pass both `afterEnteredOn` and `afterId` from `nextCursor` to retrieve the next page. It does not calculate a total count or load the full matching set into memory.

The shared-token read path is broader than dashboard-specific access: anyone holding a valid shared token can request Vital Records for any client in a selected date range. These records may include sensitive identity-document information. Do not treat the shared token as the long-term authorization design.

`AdminToken` is issued by `POST /admin_login`, expires after seven days, and currently has no endpoint-level permission scopes. Reusing one administrator's token for all dashboard users would give the dashboard broad admin authority and make activity attributable to that one account rather than to the actual user.

## Target Design

The dashboard should authenticate its users independently and call the Joppa API through a trusted server-side backend. The backend should enforce dashboard-user permissions, keep Joppa credentials out of browser code, and send an identity the API can authorize and audit.

Choose one of these authorization models before implementation:

1. **Per-user admin access:** For dashboard users who are Joppa administrators, authenticate each person with their own Joppa admin account. Store their token server-side in a protected session or credential store. Never share an administrator token across users.
2. **Dashboard-specific access:** If dashboard users are not Joppa admins, create a dedicated dashboard identity/credential with only Vital Records read permission and only the permitted client scope. Do not use a normal admin token as a service credential.

The second model is preferable when users need dashboard access without receiving broad Joppa administrator permissions. The current `AdminToken` mechanism does not support scopes, so a dashboard-specific credential or role requires API authorization work.

## Implementation Plan

### Phase 1: Temporary Operation

- Keep shared-token access read-only; keep create, update, and retrieve admin-only.
- Restrict who can access the dashboard and protect its shared credential using the dashboard host's secret-management facilities.
- Avoid placing credentials in client-side JavaScript, source control, or dashboard configuration visible to end users.
- Record that this is a temporary exception and set an owner/date to remove it.

### Phase 2: Authentication and Authorization Design

- Identify the dashboard audience: Joppa admins, other authenticated staff, or both.
- Define whether access is read-only and which clients each user may view.
- Select per-user admin tokens or a dashboard-specific least-privilege credential based on that audience.
- Define token expiration, revocation, rotation, and the expected response when a user's access is removed.

### Phase 3: API and Dashboard Changes

- Add an authorization policy for Vital Records reads that checks both the caller's role and client-level access; do not rely on the client ID query parameter as authorization.
- If using a dashboard identity, give it only the Vital Records read permission. Keep write and retrieve operations admin-only.
- Route dashboard requests through its backend. The backend authenticates the dashboard user, obtains/uses the appropriate Joppa credential server-side, and calls the API.
- Add audit records for Vital Records reads and changes, identifying the actual dashboard user or service identity.
- Add tests proving permitted users can read only authorized clients, unauthorized users cannot read, and the dashboard identity cannot create, edit, or retrieve records.

### Phase 4: Rollout and Removal

- Deploy the API policy and dashboard authentication together, initially verifying with a small set of authorized users.
- Confirm audit attribution, client-level authorization, credential rotation/revocation, and failure handling.
- Remove shared `PassToken` access from `getClientVitalRecords` after the new flow is in use.
- Revoke any temporary shared credential and review logs for use during the transition.

## Completion Criteria

- No shared volunteer token or broad administrator token is embedded in the dashboard or used by all dashboard users.
- Every Vital Records read is authorized for the authenticated identity and the requested client.
- Reads and writes are attributable in audit logs.
- The dashboard identity has no write/retrieve permission unless that capability is explicitly approved.
- Automated API tests cover both allowed and denied access, including cross-client access.
- Temporary shared-token access has been removed.
