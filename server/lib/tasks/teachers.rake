TRUE_VALUES = %w[1 y Y true TRUE True].freeze

namespace :teacher do
  desc 'Creates a new Teacher (logable user) in the database'
  task :create, %i[email password name last_name] => :environment do |_, args|
    email = args[:email] || prompt('Email: ')
    password = args[:password] || prompt('Password: ')
    name = args[:name] || prompt('Name: ')
    last_name = args[:last_name] || prompt('LastName: ')
    admin = TRUE_VALUES.include?(ENV['admin']) || false

    teacher = Teacher.new(email: email, password: password, name: name, last_name: last_name, admin: admin)
    unless teacher.save
      warn('Cannot create a new teacher:')
      teacher.errors.full_messages.each do |message|
        warn(" * #{message}")
      end
    end
  end

  desc 'Promotes a teacher to admin.'
  task :promote, %i[email] => :environment do |_, args|
    email = args[:email] || prompt('Email: ')

    teacher = Teacher.where(email: email)
    teacher.promote
    unless teacher.save
      warn('Cannot create a new teacher:')
      teacher.errors.full_messages.each do |message|
        warn(" * #{message}")
      end
    end
  end

  desc 'Demotes a teacher from admin.'
  task :demote, %i[email] => :environment do |_, args|
    email = args[:email] || prompt('Email: ')

    teacher = Teacher.where(email: email)
    teacher.demote
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
