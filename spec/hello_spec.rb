require "spec_helper"

describe "#hello_t" do
  let (:names) { ["Tim", "Tom", "Jim"] }

  it "calls the block once for each element in the passed-in array" do
    expect{hello_t(names){|name| puts "Hi, #{name}" if name.start_with?("T") }}.to output("Hi, Tim\nHi, Tom\n").to_stdout
  end

  it "returns the original array" do
    expect(hello_t(names) {|name| puts "Hi, #{name}" if name.start_with?("T") }).to eq(names)
  end

  it "is not hard-coded" do
    other_names = ["tim", "tom", "jim"]
    expect{hello_t(other_names){|name| puts "Hi, #{name}" if name.start_with?("t") }}.to output("Hi, tim\nHi, tom\n").to_stdout
  end
end
