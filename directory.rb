def print_header
  puts "The students of Villains Academy".center(100)
  puts "—————————————————————————————————".center(100)
end

def print_footer(students)
  puts "Overall, we have #{@students.count} great student(s)".center(100)
end

def print(students)
    index = 0
    if !@students.empty?
    while index < @students.length do
    #students.each_with_index do |student, index|
      puts "#{index + 1}.  #{@students[index][:name]}, #{@students[index][:country]} is joining (#{@students[index][:cohort]}) they are #{@students[index][:height]}cm tall".center(100)
      index = index + 1
    end
    else
      puts "No students to print".center(100)
    end
end

def input_students
  @students = []
  puts "Please enter the names of the students".center(100)
  puts "To finish, just hit return twice".center(100)
  name = gets.chomp

  cohort = add_cohort
  puts "Please enter the country where #{name} was born: ".center(100)
  country = gets.chomp
  puts "Please enter #{name}'s height in cm".center(100)
  height = gets.chomp

  while !name.empty? do
      @students << {name: name, cohort: cohort.to_sym, country: country, height: height}
      puts "Now we have #{@students.count} student(s). Do you want to enter another student's name? ".center(100)
      puts "If not just hit return".center(100)
      name = gets.chomp
      if name.empty?
        break
      end
      cohort = add_cohort
      puts "Please enter the country where #{name} was born: ".center(100)
      country = gets.chomp
      puts "Please enter #{name}'s height in cm".center(100)
      height = gets.chomp
    end
  @students
end

def add_cohort
  cohort_hash = { 1 => :January, 2 => :Feburary, 3 => :March, 4 => :April,
    5 => :May, 6 => :June, 7 => :Jully, 8 => :August, 9 => :September,
    10 => :October, 11 => :November,
    12 => :December}
    puts "Which month's cohort would you like to join (1-12): ".center(100)
    num = gets.strip.to_i
    if cohort_hash.has_key?num
      cohort = cohort_hash[num]
    else
      cohort = cohort_hash[1]
    end
    cohort
end

def sort_by_month
  puts "Please enter the month you want to sort by: "
  month = gets.chomp.capitalize.to_sym
  @students = @students.map {|h| h[:cohort] == month ? h : nil}.compact
  return @students
end

def enter_students
  if @students != nil
    @students = input_students
  else
    puts "No students to print".center(100)
  end
end

def show_students
  print_header
  students = @students
  print(students)
  print_footer(students)
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
end

def process(selection)
  case selection
  when "1"
    enter_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    exit
  else
    puts "I don't know what you meant, try again"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save students to file"
  puts "4. Load the students from file"
  puts "9. Exit"
end

def load_students
  file = File.open("students.csv", "r")
  file.readlines.each do |line|
  name, cohort, country, height = line.chomp.split(',')
    @students << {name: name, cohort: cohort.to_sym, country: country, height: height}
  end
  file.close
end

def interactive_menu
  @students = []
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
