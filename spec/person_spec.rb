# files for creation and testing
space_file = File.open("input-files/space-style.txt")
pipe_file = File.open("input-files/pipe-style.txt")
comma_file = File.open("input-files/comma-style.txt")



#Space text parse
  Person.create_from_file_data(space_file)
#Comma text parse
  Person.create_from_file_data(comma_file)


describe 'Person #create_with_file:' do 
  it 'Takes a raw text file and creates one person instance per line of data.' do
#Pipe text parse
    Person.create_from_file_data(pipe_file)
    
    person1 = Person.all.find{|p| p.last_name == "Bouillon"}
    person2 = Person.all.find{|p| p.first_name == "Radek"}
    person3 = Person.all.find{|p| p.date_of_birth == "3/3/1985"}
    expect(Person.all).to include(person1, person2, person3)
  end
end

describe 'Person #create_from_file_data error handling:' do
    it 'Handles if the passed item cannot respond to #read.' do
        not_file1  = ""
        not_file2 = []
        error1 = Person.create_from_file_data(not_file1)
        error2 = Person.create_from_file_data(not_file2)
        #Error case

        expect(error1).to eq("Undefined method 'read' - ensure input is a file")
        expect(error2).to eq("Undefined method 'read' - ensure input is a file")
    end
end


describe 'Person #create_with_string:' do
  it 'Takes a string that is formatted in the space, comma, or pipe style and creates a person instance.' do
    person1 = Person.create_with_string("Kournikova Anna F F 6-3-1975 Red")
    person2 = Person.create_with_string("Abercrombie, Neil, Male, Tan, 2/13/1943")
    person3 = Person.create_with_string("Smith | Steve | D | M | Red | 3-3-1985")
    expect(Person.all).to include(person1, person2, person3)
    3.times {Person.all.pop}
  end
end

describe 'Person #create_with_string error handling:' do
    it 'Handles formatting errors if parameters are not a string or if the wrong number of parameters are passed in the parsed string.' do
        error1 = Person.create_with_string({name: "Bob"})
        error2 = Person.create_with_string("Smith Steve Sad Lion ")   
        expect(error1).to eq("Please provide a string")
        expect(error2).to eq("Please provide the proper # of arguments")
    end
end


describe "Person #sort_by_gender_and_last_name: Order #1" do
    it 'Sorts all instances by gender and last name ascending.' do

         expect(Person.sort_by_gender_and_last_name).to eq( ["Hingis Martina Female 4/2/1979 Green",
            "Kelly Sue Female 7/12/1959 Pink",
            "Kournikova Anna Female 6/3/1975 Red",
            "Seles Monica Female 12/2/1973 Black",
            "Abercrombie Neil Male 2/13/1943 Tan",
            "Bishop Timothy Male 4/23/1967 Yellow",
            "Bonk Radek Male 6/3/1975 Green",
            "Bouillon Francis Male 6/3/1975 Blue",
            "Smith Steve Male 3/3/1985 Red"].join("\n"))
    end

end 

describe "Person #sort_by_date_of_birth_and_last_name: Order #2" do
    it 'Sorts all instances by DOB and last name ascending.' do
         expect(Person.sort_by_date_of_birth_and_last_name).to eq( ["Abercrombie Neil Male 2/13/1943 Tan",
            "Kelly Sue Female 7/12/1959 Pink",
            "Bishop Timothy Male 4/23/1967 Yellow",
            "Seles Monica Female 12/2/1973 Black",
            "Bonk Radek Male 6/3/1975 Green",
            "Bouillon Francis Male 6/3/1975 Blue",
            "Kournikova Anna Female 6/3/1975 Red",
            "Hingis Martina Female 4/2/1979 Green",
            "Smith Steve Male 3/3/1985 Red"].join("\n"))
    end

end 

describe "Person #sort_by_last_name_desc: Order #3" do
    it 'Sorts all instances by last name descending.' do
         expect(Person.sort_by_last_name_desc).to eq( ["Smith Steve Male 3/3/1985 Red",
            "Seles Monica Female 12/2/1973 Black",
            "Kournikova Anna Female 6/3/1975 Red",
            "Kelly Sue Female 7/12/1959 Pink",
            "Hingis Martina Female 4/2/1979 Green",
            "Bouillon Francis Male 6/3/1975 Blue",
            "Bonk Radek Male 6/3/1975 Green",
            "Bishop Timothy Male 4/23/1967 Yellow",
            "Abercrombie Neil Male 2/13/1943 Tan"].join("\n"))
    end

end 

def display_data
  data_arr = [Person.sort_by_gender_and_last_name, Person.sort_by_date_of_birth_and_last_name, Person.sort_by_last_name_desc]

  print "--- Formatted Data ---\n"

  data_arr.each.with_index(1) do |sort_method_data, count|
    print "\nOutput #{count}\n"
    puts sort_method_data
  end

  print "\n---Tests---\n"
end

display_data()
