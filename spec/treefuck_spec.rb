require_relative '../lib/treefuck.rb'

describe "Treefuck" do
  it "can output the default value with `.`" do
    expect { Treefuck.new(".") }.to output('0').to_stdout
  end
  it "can output several times with `..`" do
    expect { Treefuck.new("..") }.to output('00').to_stdout
  end
  it "can take input with `,`" do
    Treefuck.any_instance.stub(gets: "8")
    expect { Treefuck.new(",.") }.to output('8').to_stdout
  end
  it "can increment the current node with `+`" do
    expect { Treefuck.new("+.") }.to output('1').to_stdout
  end
  it "can decrement the current node with `-`" do
    expect { Treefuck.new("-.") }.to output('-1').to_stdout
  end
  it "can output before and after incrementing" do
    expect { Treefuck.new(".+.") }.to output('01').to_stdout
  end
  it "can increment an input" do
    Treefuck.any_instance.stub(gets: "8")
    expect { Treefuck.new(",+.") }.to output('9').to_stdout
  end
  it "can iterate inside the `[]` blocks" do
    Treefuck.any_instance.stub(gets: "3")
    expect { Treefuck.new(",[.-]") }.to output('321').to_stdout
  end
  it "can make left children and increment them seperately" do
    expect { Treefuck.new("<++.") }.to output('2').to_stdout
    expect { Treefuck.new("<++|.") }.to output('0').to_stdout
  end
  it "can make right children and increment them seperately" do
    expect { Treefuck.new(">++.") }.to output('2').to_stdout
    expect { Treefuck.new(">++|.") }.to output('0').to_stdout
  end
  it "remembers parent and children" do
    expect { Treefuck.new("+<++|<|.") }.to output('1').to_stdout
    expect { Treefuck.new("+<++|<.") }.to output('2').to_stdout
  end
  it "can iterate through parent and child" do
    Treefuck.any_instance.stub(gets: "3")
    expect { Treefuck.new(",[>+.|-],[<+.|-]")}.to output('123123').to_stdout
  end
  it "outputs a sum of children" do
    Treefuck.any_instance.stub(gets: "4")
    expect { Treefuck.new("<,|>,|<[-|+<]|>[-|+>]|.") }.to output("8").to_stdout
  end
  it "can't work its way up uninitialized ancestors" do
    expect { Treefuck.new("|||+|>.") }.to raise_error(StandardError)
    expect { Treefuck.new("|||+|<.") }.to raise_error(StandardError)
    expect { Treefuck.new("|") }.to raise_error(StandardError)
  end
  # it "can print 'Hello World!'" do
  #   hello_world_string = "++++++++[>++++[>++>+++>+++>+||||-]>+>+>->>+[|]|-]>>.>---.+++++++..+++.>>.|-.|.+++.------.--------.>>+.>++."
  #   expect { Treefuck.new(hello_world_string) }.to output("?").to_stdout
  # end
end
