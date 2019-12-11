require "test/unit/assertions"
include Test::Unit::Assertions

def calculate_fuel(mass)
  # Fuel required to launch a given module is based on its mass.
  #  Specifically, to find the fuel required for a module,
  #  take its mass, divide by three, round down, and subtract 2.
  return (mass / 3).floor - 2
end

def total_fuel
  fuel = 0

  File.open('input.txt').each do |mass|
    fuel += calculate_fuel(mass.chomp.to_i)
  end

  return fuel
end

# Ensure that we're adding total fuel cost correctly
def _test_total_fuel(mass_list)
  fuel = 0

  mass_list.each do |mass|
    fuel += calculate_fuel(mass.to_i)
  end

  return fuel
end

# Ensure that we're calculating fuel from mass correctly
def _test_fuel
  # For a mass of 12, divide by 3 and round down to get 4, then subtract 2 to get 2.
  # For a mass of 14, dividing by 3 and rounding down still yields 4, so the fuel required is also 2.
  # For a mass of 1969, the fuel required is 654.
  # For a mass of 100756, the fuel required is 33583.
  assert_equal 2, calculate_fuel(12)
  assert_equal 2, calculate_fuel(14)
  assert_equal 654, calculate_fuel(1969)
  assert_equal 33583, calculate_fuel(100756)
  assert_equal 4, _test_total_fuel([12, 14])
  assert_equal 658, _test_total_fuel([12, 14, 1969])
end
_test_fuel

puts total_fuel
