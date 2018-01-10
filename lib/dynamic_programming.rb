class DynamicProgramming
  attr_accessor :blair_nums
  def initialize
    @blair_nums = {1=>1,2=>2,3=>6}
    @odd_nums=[1,3,5]
  end
  

  def blair_nums(n)
    return @blair_nums[1] if (n == 1)
    return @blair_nums[2] if (n == 2)
    return @blair_nums[3] if (n == 3)
    return @blair_nums[n] if (@blair_nums[n])

    
    @blair_nums[n]=blair_nums(n-1)+blair_nums(n-2) + odd_or_add(n) 
    # p @blair_nums
    # puts n
    # p @odd_nums
    @blair_nums[n]
  end

  def odd_or_add(n)
    return @odd_nums[n-1] if @odd_nums[n-1]
    while ( @odd_nums.length<n-1)
      @odd_nums.push(@odd_nums[-1]+2)
    end
    return (@odd_nums[-1])

  end

  def frog_hops_bottom_up(n)

  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
