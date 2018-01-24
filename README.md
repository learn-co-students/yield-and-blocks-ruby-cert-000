# Yield and Blocks

## Objectives

1. Understand how the `yield` keyword works in Ruby.
2. Practice using `yield` with blocks.
3. Gain a deeper understanding of the common iterator `#each`.

## Calling a method with a block

A block is a bit of code enclosed in `do`/`end` keywords or curly brackets (`{}`). We've seen methods like `#each` and `#collect` being called with blocks.

Let's take a look at the following example:

```ruby
["Tim", "Tom", "Jim"].each do |name|
  puts "Hi, #{name}"
end
```

Here we are calling `#each` on our array of names. The `#each` method is being called with a block, the code between the `do`/`end` keywords. Each element contained in our array is getting passed, or yielded, to the block on each successive step of the iteration.

Let's take a look at another example. In the below snippet, we're writing a method that `puts` out every word in the array that starts with the letter `"T"`:

```ruby
["Tim", "Tom", "Jim"].each do |name|
  if name.start_with?("T")
    puts "Hi, #{name}"
  end
end
```

Once again, our `#each` method is yielding each element of the array to the accompanying block. The code in the block is executed, using each successive element from the array, as the iteration proceeds.

But how do `#each` and the other iterators like `#collect` actually pass, or yield, each successive element to the accompanying block? Under the hood, these methods rely on the `yield` keyword.

Let's take a closer look at `yield` and try to build our own custom methods that utilize it.

## The `yield` keyword

The `yield` keyword, when used inside the body of a method, will allow you to call that method with a block of code and pass the torch, or *yield*, to that block. Think of the `yield` keyword as saying: "Stop executing the code in this method, and instead execute the code in this block. Then, return to the code in the method."

Let's look at the following example:

```ruby
def yielding
  puts "the program is executing the code inside the method"
  yield
  puts "now we are back in the method"
end
```

To call this method with a block, we use the following syntax:

```ruby
yielding { puts "the method has yielded to the block!" }
```

or:

```ruby
yielding do
  puts "the method has yielded to the block!"
end
```

When we call `#yielding` with the above block, we will output:

```bash
the program is executing the code inside the method
the method has yielded to the block!
now we are back in the method
```


#### `yield`ing with parameters

The `yield` keyword can take parameters. In other words, if you use `yield` and give it an argument, it will pass that argument to the block and that data will become available to the code in the block.

For example:

```ruby
def yielding_with_arguments(num)
  puts "the program is executing the code inside the method"
  yield(num)
  puts "now we are back in the method"
end
```

We can call `#yielding_with_arguments` by providing both an argument *and* a block containing a placeholder, `|i|` in the following example, which will accept the argument passed to `yield`:

```ruby
yielding_with_arguments(2) {|i| puts i * 2}
```

We call our method with an argument:

```ruby
yielding_with_arguments(2)
```

and a block:

```ruby
{ |i| puts i * 2 }
```

The `|i|` (placeholder variable in between pipes) is our placeholder for the `yield`ed value. The `puts i * 2` is the code we actually want to enact with our `yield`ed value.

So, the above method call will output:

```bash
the program is executing the code inside the method
4
now we are back in the method
```

The syntax inside the block might look familiar — it is how we pass items from a collection into a block, one by one, when we use an iterator like `#each`.

## Code-Along: Building our own method with `yield`

Let's revisit our earlier example of a call to the `#each` method that only `puts` out a greeting if the word we pass into the block starts with the letter `"T"`.

```ruby
["Tim", "Tom", "Jim"].each do |name|
  if name.start_with?("T")
    puts "Hi, #{name}"
  end
end
```

In this example, we'll be building our own method, `#hello_t`.

Open up `lib/hello.rb`. We'll be coding the body of the `#hello_t` method.

#### Step 1: Defining our method to accept an argument

Our method needs to operate on an array so let's define it to take in an argument:

```ruby
# lib/hello.rb

def hello_t(array)
  # code here
end
```

Great, let's move on.

#### Step 2: Enacting an iteration

We know that we want to yield each element of the array successively to a block that we will call this method with. Let's use a `while` loop to create our iteration:

```ruby
def hello_t(array)
  i = 0

  while i < array.length
    i = i + 1
  end
end
```

##### `while` loop review

In the code above, we set a counter variable, `i`, equal to `0`. We start our `while` loop and tell it to execute the code in between the `while` and `end` keywords as long as `i` is *less* than the length of the array. Inside our `while` loop, we increment the value of `i`.

Now, as we iterate through the array, we need to `yield` each member of the array to the block that we'll pass to our `#hello_t` method.

#### Step 3: Yielding to the block

The first time through our `while` loop, `i` is equal to `0`. The second time through the loop, `i` is `1`, and so on. This will continue until `i` is equal to the index number of the last item in our array.

So, during each step of the `while` loop, `i` equals a given index number of our array. We can use this information to yield each successive value stored in the array to the passed-in block:

```ruby
def hello_t(array)
  i = 0

  while i < array.length
    yield array[i]
    i = i + 1
  end
end
```

Here, we use the bracket (`[]`) method to grab the value of each successive index element as we proceed through our `while` loop, `yield`ing each to a block. Now we're ready to call our method.

#### Step 4: Calling our method

Let's call our method, passing in the following array as an argument:

```ruby
["Tim", "Tom", "Jim"]
```

```ruby
hello_t(["Tim", "Tom", "Jim"]) do |name|
  if name.start_with?("T")
    puts "Hi, #{name}"
  end
end
```

Copy and paste the above method call into your `lib/hello.rb` file (paste it below the line that reads `# call your method here!`). Then, run the file with the `ruby lib/hello.rb` command in your terminal. You should see the following:

```bash
Hi, Tim
Hi, Tom
```

We're calling our method with the array of names as an argument and accompanying that method call with a block that accepts a `|name|` parameter. If the passed-in name begins with the letter `"T"`, the block will `puts` out a greeting. Good job! Before moving on to Step 5, be sure to remove the above method call from lib/hello.rb.

#### Step 5: Passing our test

Go ahead and run the test suite by typing `learn` into your terminal in this lesson's directory. You'll see that our test expects us to return the original array, but our method is currently returning `nil`:

```
Failures:

  1) #hello_t returns the original array
     Failure/Error:
       expect( hello_t(names){ |name| puts name } )
         .to eq(names)

       expected: ["Tim", "Tom", "Jim"]
            got: nil

       (compared using ==)
     # ./spec/hello_spec.rb:13:in `block (2 levels) in <top (required)>'

Finished in 0.01509 seconds (files took 0.1233 seconds to load)
2 examples, 1 failure

Failed examples:

rspec ./spec/hello_spec.rb:12 # #hello_t returns the original array
```

How can we fix this? We can tell our `#hello_t` method to return the original array:

```ruby
def hello_t(array)
  i = 0

  while i < array.length
    yield(array[i])
    i = i + 1
  end

  array
end
```

Here, we tell our method to return the original array simply by having that array be the last line of the method. Whatever is evaluated last in a method will be the return value for the whole method. If you run the test again, you should be passing (although the "test suite," the full collection of tests, is not quite done!).


### Advanced: Defining a method to optionally take a block

In the examples above, our methods will break if they are called without an accompanying block. Go ahead and try it — you'll see a `no block given (yield) (LocalJumpError)`. This is bad because we like our code to be flexible and accommodating. In other words, we don't want our code to break so easily and in such an ugly, uncontrolled manner.

Let's refactor our `#hello_t` method so that it can be called either with or without a block:

```ruby
def hello_t(array)
  if block_given?
    i = 0

    while i < array.length
      yield(array[i])
      i = i + 1
    end

    array
  else
    puts "Hey! No block was given!"
  end
end
```

**The `block_given?` method** returns `true` if the method that contains `block_given?` is called with a block and `false` if it is not.

Our `#hello_t` method will `yield` each element of the array to the block if a block is present. Otherwise, it will `puts` out a helpful phrase.

## Enumerators under the hood

You've already worked with enumerator methods like `#each` and `#collect`. These methods are called on collections, such as arrays. They take blocks as their arguments and *yield* each element of the collection to the block, allowing the code in the block to be applied to each element of the collection.

In the code-along above, we built our own implementation of the `#each` method. We used `while` to iterate through each element of the array and passed, or `yield`ed, each successive element to an accompanying block. That block used a parameter placeholder, `|name|`, to set a variable, `name`, equal to whatever value is `yield`ed into the block at each step of the iteration. That block also contained code to execute with each `yield`ed element in turn.

You can read more about the `yield` keyword and blocks in Ruby from the resources below:

* [All About Ruby](http://allaboutruby.wordpress.com/) - [Ruby Blocks](http://allaboutruby.wordpress.com/2006/01/20/ruby-blocks-101/)
* [Reactive's Tips](http://www.reactive.io/tips/) - [Understanding Ruby Blocks, Procs, and Lambdas](http://www.reactive.io/tips/2008/12/21/understanding-ruby-blocks-procs-and-lambdas)
* [Mix&Go](https://mixandgo.com/) - [Mastering-ruby-blocks-in-less-than-5-minutes](https://mixandgo.com/blog/mastering-ruby-blocks-in-less-than-5-minutes)

<p data-visibility='hidden'>View <a href='https://learn.co/lessons/yield-and-blocks' title='Yield and Blocks'>Yield and Blocks</a> on Learn.co and start learning to code for free.</p>
