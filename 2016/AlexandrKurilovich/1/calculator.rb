#!/usr/bin/env ruby
numbers = 0
operators = 0

class String
  def operator?
    true if /^[\+\-\/\*!]+$/.match(self)
  end

  def number?
    true if Float self rescue false
  end

  def valid?
    true if self.operator? or self.number?
  end
end

def reset(a,b)
  a = a.to_i.to_s(2).reverse
  b.to_i.times {  a[a.index("1")] = "0"}
  a.reverse.to_i(2)
end

def calc(b,a,operator)
  case operator
  when "+"
    return a+b
  when "-"
    return a-b
  when "*"
    return a*b
  when "/"
    return a/b
  when "!"
    reset(a,b)
  end
end

expr = []

while numbers - operators != 1 or operators == 0
  str = gets.chomp
  if str.valid?
    expr.push(str)
    p str
    numbers+=1 if str.number?
    operators+=1 if str.operator?
  else
    puts "Wrong input"
  end
end

stack = []
res = 0
expr.each do |x|
  if x.number?
    stack.push x.to_f
  else
    res = calc(stack.pop, stack.pop, x)
    stack.push res
  end
end
puts "result: #{res}"
