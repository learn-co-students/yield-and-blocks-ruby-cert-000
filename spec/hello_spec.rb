require "spec_helper"

describe "#hello_t" do
  let (:names) { ["Tim", "Tom", "Jim"] }

  it "only passes names that start with 'T' to the block" do
    expect{hello_t(names){|name| puts "Hi, #{name}" if name.start_with?("T") }}.to output("Hi, Tim\nHi, Tom\n").to_stdout
  end

  it "returns the original array" do
    expect(hello_t(names) {|name| puts "Hi, #{name}" if name.start_with?("T") }).to eq(names)
  end

  it "is case insensitive" do
    other_names = ["tim", "tom", "jim"]
    expect{hello_t(other_names){|name| puts "Hi, #{name}" if name.start_with?("t") }}.to output("Hi, tim\nHi, tom\n").to_stdout
  end
end
