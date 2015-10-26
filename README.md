# Yield and Blocks

can combine elements from https://github.com/learn-co-curriculum/my-each and bit from https://github.com/learn-co-curriculum/ruby-closures-readme

Take the beginning of my-each. The ruby-closures-readme is a bit too much.

This is going to be a hard one to write, but here is roughly an outline:

You may have noticed after doing a bunch of previous labs that working with Arrays and many other things you get a common pattern: Set up the array, then do some operation on each thing. First write a method that prints out every item in array that starts with B. then write a method that prints out the reverse of every word. Notice that they are roughly the same. (I know a lot of this is reptition from our enumerators vs iteration reading, that's ok). You've seen this get resolved with the .each method by re-writing the loops with #each. But how does that work? 

Then go into translating the examples you gave of printing out and reversing into a method that takes in a yield. Don't call it each...I know that's what it is. Make sure to include how to call the method you just created! Another thing that is helpful is doing a puts before and after the yield command to show exactly when the code you passed in gets called.
