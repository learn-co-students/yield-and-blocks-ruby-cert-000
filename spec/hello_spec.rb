require "spec_helper"

describe "#hello_t" do 
  it "takes in an argument of an array and puts out a greeting to each person in the array whose name begins with the letter T" do 
    array = ["Tim", "Tom", "Jim"]
    expect{hello_t(array){|name| puts "Hi, #{name}" if name.start_with?('T') }}.to output("Hi, Tim\nHi, Tom\n").to_stdout
    expect(hello_t(array) {|name| puts "Hi, #{name}" if name.start_with?('T') }).to eq(array)
  end
end
