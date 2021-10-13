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

  def self.output_file
    file = File.new("output.txt", "w+") 
    File.write("output.txt", self.write_data.join("\n"))  
    file.close
  end

  def self.sort_by_gender_and_last_name
    data = self.all.sort_by {|person| [person.gender, person.last_name ]}
    self.output_text(data)
  end
 
  def self.sort_by_date_of_birth_and_last_name
    data = self.all.sort_by do |person| 
        [Date.strptime(person.date_of_birth, "%m/%d/%Y"), person.last_name]
    end
    self.output_text(data)
  end

  def self.sort_by_last_name_desc
    data = self.all.sort_by {|person| person.last_name}.reverse
    self.output_text(data)
  end

  def stringify_instance
    "#{@last_name} #{@first_name} #{@gender} #{@date_of_birth} #{@color}"
  end
  

  private

  
  def self.output_text(data_arr)
    data_arr.collect {|person| person.stringify_instance }.join("\n")
end  

def self.write_data
    data_arr = [Person.sort_by_gender_and_last_name, Person.sort_by_date_of_birth_and_last_name, Person.sort_by_last_name_desc]
    data_arr.collect.with_index(1) do |sort_method_data, count|
        sort_method_data.prepend("\nOutput #{count}\n") 
    end
end

def self.sanitize(str_params) 
  # string_params input varies based on string passed to the function
  # For reference, and with their corresponding array index: 
        #                              [0]       [1]       [2]             [3]           [4]          [5]
        #  The pipe-delimited file: LastName | FirstName | MiddleInitial | Gender | FavoriteColor | DateOfBirth
        #  The comma-delimited file: LastName, FirstName,  Gender,      FavoriteColor,  DateOfBirth   
        #  The space-delimited file: LastName  FirstName  MiddleInitial    Gender      DateOfBirth   FavoriteColor

  data_arr = str_params.gsub(/\|\s|,/, "").split(" ")
  #remove middle initial as needed
  data_arr.slice!(2) if data_arr.length == 6
  # handle if size of input is incorrect
  if data_arr.length != 5 then return "Error" end      
  # handle gender
  data_arr[2] == "F" || data_arr[2] == "Female" ? data_arr[2] = "Female" : data_arr[2] = "Male"
  #swap DOB/Color if needed and sanitize DOB
  data_arr[3], data_arr[4] = data_arr[4], data_arr[3] if data_arr[3].upcase != data_arr[3]
  data_arr[3].gsub!("-", "/")
  #output [last_name[0], first_name[1], gender[2], date_of_birth[3], color[4]]
  data_arr
end

end

