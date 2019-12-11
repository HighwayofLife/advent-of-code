require "test/unit/assertions"
include Test::Unit::Assertions

def calculate_fuel(mass)
  # Fuel required to launch a given module is based on its mass.
  #  Specifically, to find the fuel required for a module,
  #  take its mass, divide by three, round down, and subtract 2.
  return (mass / 3).floor - 2
end

def module_fuel
  fuel = 0

  File.open('input.txt').each do |mass|
    fuel += calculate_fuel(mass.chomp.to_i)
  end

  return fuel
end

def fuel_mass_fuel(fuel_load)
  total_fuel = fuel_load
  fuel_cost = total_fuel

  while fuel_cost > 0
    fuel_cost = calculate_fuel(fuel_cost)
    if (fuel_cost < 0)
      break
    end
    total_fuel += fuel_cost
  end

  return total_fuel
end

def calculate_total_fuel
  fuel = 0

  File.open('input.txt').each do |mass|
    fuel += fuel_mass_fuel(calculate_fuel(mass.chomp.to_i))
  end

  return fuel
end

# Ensure that we're adding total fuel cost correctly
def _test_module_fuel(mass_list)
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
  assert_equal 4, _test_module_fuel([12, 14])
  assert_equal 658, _test_module_fuel([12, 14, 1969])

  # A module of mass 14 requires 2 fuel. This fuel requires no further fuel (2 divided by 3 and rounded down is 0, which would call for a negative fuel), so the total fuel required is still just 2.
  assert_equal 2, fuel_mass_fuel(_test_module_fuel([14]))
  # At first, a module of mass 1969 requires 654 fuel. Then, this fuel requires 216 more fuel (654 / 3 - 2). 216 then requires 70 more fuel, which requires 21 fuel, which requires 5 fuel, which requires no further fuel. So, the total fuel required for a module of mass 1969 is 654 + 216 + 70 + 21 + 5 = 966.
  assert_equal 966, fuel_mass_fuel(_test_module_fuel([1969]))
  # The fuel required by a module of mass 100756 and its fuel is: 33583 + 11192 + 3728 + 1240 + 411 + 135 + 43 + 12 + 2 = 50346.
  assert_equal 50346, fuel_mass_fuel(_test_module_fuel([100756]))
end
_test_fuel

puts fuel_mass_fuel(module_fuel)
puts calculate_total_fuel

