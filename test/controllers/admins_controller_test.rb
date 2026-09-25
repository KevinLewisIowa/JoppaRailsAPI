require 'test_helper'

class AdminsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = Admin.create!(
      email: 'regular-admin@example.com',
      password: 'Current1!Pass',
      password_confirmation: 'Current1!Pass',
      role: :admin,
      active: true
    )
    @admin_token = AdminToken.create!(
      admin: @admin,
      token: SecureRandom.hex(16),
      expires_at: 1.day.from_now
    )
  end

  test 'regular admin can change their own password' do
    patch '/admin_profile/change_password',
      params: {
        current_password: 'Current1!Pass',
        new_password: 'Updated1!Pass',
        confirm_password: 'Updated1!Pass'
      },
      headers: { 'Authorization' => "Bearer #{@admin_token.token}" },
      as: :json

    assert_response :success
    assert @admin.reload.authenticate('Updated1!Pass')
  end

  test 'regular admin cannot reset another admin password' do
    other_admin = Admin.create!(
      email: 'other-admin@example.com',
      password: 'OtherPass1!',
      password_confirmation: 'OtherPass1!',
      role: :admin,
      active: true
    )

    post "/admins/#{other_admin.id}/reset_password",
      headers: { 'Authorization' => "Bearer #{@admin_token.token}" },
      as: :json

    assert_response :unauthorized
    assert other_admin.reload.authenticate('OtherPass1!')
  end
end