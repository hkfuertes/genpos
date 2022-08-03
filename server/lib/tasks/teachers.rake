namespace :teachers do
  desc 'Creates a new Teacher (logable user) in the database'
  task create: :environment do
    email = prompt('Email: ')
    password = prompt('Password: ')
    name = prompt('Name: ')
    last_name = prompt('LastName: ')

    teacher = Teacher.new(email:, password:, name:, last_name:)
    unless teacher.save
      warn('Cannot create a new teacher:')
      teacher.errors.full_messages.each do |message|
        warn(" * #{message}")
      end
    end
  end
end

def prompt(message)
  print(message)
  $stdin.gets.chop
end
