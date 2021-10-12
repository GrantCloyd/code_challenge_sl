
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
  
  def stringify_instance
  "#{@last_name} #{@first_name} #{@gender} #{@date_of_birth} #{@color}"
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


 

  private

  def self.sanitize(str_params)  
            # replace all '| ' and ',' with an empty string 
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
    data_arr.each {|person| p person.stringify_instance}
  end


end

#Space
Person.create_with_string("Kournikova Anna F F 6-3-1975 Red")
    Person.create_with_string("Hingis Martina M F 4-2-1979 Green")
        Person.create_with_string("Seles Monica H F 12-2-1973 Black")
#Comma
Person.create_with_string("Abercrombie, Neil, Male, Tan, 2/13/1943")
    Person.create_with_string("Bishop, Timothy, Male, Yellow, 4/23/1967")
        Person.create_with_string("Kelly, Sue, Female, Pink, 7/12/1959")
#Pipe
Person.create_with_string("Smith | Steve | D | M | Red | 3-3-1985")
    Person.create_with_string("Bonk | Radek | S | M | Green | 6-3-1975")
        Person.create_with_string("Bouillon | Francis | G | M | Blue | 6-3-1975")
#Error
p Person.create_with_string("Smith Steve Sad Lion ")
    p   Person.create_with_string({name: "Bob"})


p Person.all

print "\n"
p "Output 1" 
Person.sort_by_gender_and_last_name
print "\n"
p "Output 2"
Person.sort_by_date_of_birth_and_last_name
print "\n"
p "Output 3"
Person.sort_by_last_name_desc
