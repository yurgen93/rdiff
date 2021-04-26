# Rdiff

Simple LCS diff ruby implementation

More about [LCS problem](https://en.wikipedia.org/wiki/Longest_common_subsequence_problem)


## Usage
```bash
> cat a.txt
hello
my
name
is
john
doe

> cat b.txt
hello
your
name
is
jonas
joe
doe

> rdiff a.txt b.txt
  hello
- my
+ your
  name
  is
- john
+ jonas
+ joe
  doe
```


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
