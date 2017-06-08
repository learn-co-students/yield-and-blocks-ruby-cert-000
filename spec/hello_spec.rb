require "spec_helper"

describe "#hello_t" do
  let (:names) { ["Tim", "Tom", "Jim"] }

  it "calls the block once for each element in the passed-in array" do
    expect{ hello_t(names){ |name| puts name } }
      .to output("Tim\nTom\nJim\n")
      .to_stdout
  end

  it "returns the original array" do
    expect( hello_t(names){ |name| puts name } )
      .to eq(names)
  end

  it "is not hard-coded" do
    other_names = ["Ali", "Jasmine", "Persephone"]

    expect{ hello_t(other_names){ |name| puts name.upcase } }
      .to output("ALI\nJASMINE\nPERSEPHONE\n")
      .to_stdout
  end

  it "fails gracefully when a block is not passed in" do
    expect{ hello_t(names) }
      .to output("Hey! No block was given!\n")
      .to_stdout
  end
end
