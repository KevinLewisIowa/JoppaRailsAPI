namespace :admins do
  desc "Create the initial Joppa admin accounts"
  task create_initial: :environment do
    admins = [
      ["Pat", "McPherren", "pat.mcpherren@joppa.org"],
      ["Sean", "Reese", "sean.reese@joppa.org"],
      ["Carrie", "Spain", "Carrie.Spain@joppa.org"],
      ["Megan", "Taylor", "megan.taylor@joppa.org"],
      ["Calvin", "Brown", "calvin.brown@joppa.org"],
      ["David", "Drake", "david.drake@joppa.org"],
      ["Jessie", "Moreno", "jessie.moreno@joppa.org"],
      ["Scott", "Strachan", "scott.strachan@joppa.org"],
      ["Jack", "Bell", "jack.bell@joppa.org"],
      ["Mark", "Breheny", "mark.breheny@joppa.org"],
      ["Kathe", "Breheny", "kathebreheny@gmail.com"],
      ["Deb", "Albecht", "debralabeyta@hotmail.com"],
      ["Greg", "Townsend", "townsendgregorya@gmail.com"],
      ["Connie", "Richards", "richardconnie63@gmail.com"],
      ["Linda", "Grathwohl", "l.grathwohl57@gmail.com"],
      ["Emily", "Thams", "emilythams@gmail.com"],
      ["Shelia", "Sinclair", "sheila.sinclair16@gmail.com"],
      ["Joan", "Miller", "joanmomiller@gmail.com"],
      ["Stephanie", "Hughes", "steph2422@icloud.com"],
      ["Jo Kay", "Boyle", "jjkboyle@gmail.com"],
      ["Andy", "Goldsworthy", "agoldsworthy25@gmail.com"],
      ["Max", "Clark", "clarkmc123@yahoo.com"],
      ["Bill", "Mech", "bill.mech@joppa.org"],
      ["Suzan", "Strandberg", "gdberg@aol.com"]
    ]

    puts "email,temp_password,status"

    admins.each do |first_name, last_name, email|
      normalized_email = email.downcase
      admin = Admin.find_by(email: normalized_email)

      if admin
        puts "#{normalized_email},,already_exists"
        next
      end

      temporary_password = Admin.new.generate_temp_password
      admin = Admin.new(
        email: normalized_email,
        first_name: first_name,
        last_name: last_name,
        role: :admin,
        requires_password_change: true,
        password: temporary_password,
        password_confirmation: temporary_password
      )

      if admin.save
        puts "#{normalized_email},#{temporary_password},created"
      else
        puts "#{normalized_email},,failed: #{admin.errors.full_messages.join('; ')}"
      end
    end
  end
end
