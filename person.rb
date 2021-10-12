require 'date'


class Person 
   attr_reader :last_name, :first_name, :gender, :date_of_birth, :color
    
  @@all = []

  def self.all
    @@all
  end

  def initialize(last_name, first_name, gender, date_of_birth, color)
    @last_name = last_name
    @first_name = first_name
    @gender = gender
    @date_of_birth = date_of_birth
    @color = color
  end 
  
  def self.create_from_file_data(file)
     data = file.read.split("\n")
     data.each {|line| self.create_with_string(line)}
    rescue NoMethodError => error
      return  "Undefined method 'read' - ensure input is a file"
  end


  def self.create_with_string(str_params)
    if str_params.class != String then return "Please provide a string" end  
    data = self.sanitize(str_params)
    if data == "Error" then return "Please provide the proper # of arguments" end   
         
         #in order: last_name, first_name, gender, date_of_birth, color
    person = Person.new(data[0], data[1], data[2], data[3], data[4]) 
    self.all << person
    person
  end

  def self.sort_by_gender_and_last_name
    data = self.all.sort_by {|person| [person.gender, person.last_name ]}
    self.output(data)
  end
 
  def self.sort_by_date_of_birth_and_last_name
    data = self.all.sort_by {|person| [Date.strptime(person.date_of_birth, "%m/%d/%Y"), person.last_name]}
    self.output(data)
  end

  def self.sort_by_last_name_desc
    data = self.all.sort_by {|person| person.last_name}.reverse
    self.output(data)
  end

  def stringify_instance
    "#{@last_name} #{@first_name} #{@gender} #{@date_of_birth} #{@color}"
  end
  

  private

  def self.sanitize(str_params)  
            # replace all '| ' and ','
    data_arr = str_params.gsub(/\|\s|,/, "").split(" ")
    #remove middle initial as needed
    data_arr.slice!(2) if data_arr.length == 6

    if data_arr.length != 5 then return "Error" end      
    
    data_arr[2] == "F" || data_arr[2] == "Female" ? data_arr[2] = "Female" : data_arr[2] = "Male"
    #swap DOB if needed and sanitize
    data_arr[3], data_arr[4] = data_arr[4], data_arr[3] if data_arr[3].upcase != data_arr[3]
    data_arr[3].gsub!("-", "/")
    data_arr
  end

  def self.output(data_arr)
    data_arr.collect {|person| person.stringify_instance }.join("\n")
  end

  

end

