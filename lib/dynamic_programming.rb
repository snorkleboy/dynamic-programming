class DynamicProgramming
  attr_accessor :blair_nums
  def initialize
    @blair_nums = {1=>1,2=>2,3=>6}
    @odd_nums=[1,3,5]

    @jumps_for = {
      1=>[[1]],
      2=>[[1,1],[2]],
      3=>[[1,1,1],[1,2],[2,1],[3]]  
    }
    # @jumps[n] = 
    @jumps = {
      1=>[[1]]
      # 2=>[[1,1],[2]],
      # 3=>[[1,1,1],[1,2],[2,1],[3]]  
      # 4=>[[1,1,1,1],[1,2,1],[2,1,1],[3,1],[4]== jumps[n-1]*+1, [1,1,2],[2,2] == jumps[n-2]*+2 , [1,3] == jumps[n-3]*+3 , [4]
    }

    @knapsack={

    }

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
    cache = frog_cache_builder(n)
    cache[n]
  end

  def frog_cache_builder(n)
    jumps_for = {
      1=>[[1]],
      2=>[[1,1],[2]],
      3=>[[1,1,1],[1,2],[2,1],[3]]  
  }
    if (n<jumps_for.keys.length)
      return jumps_for
    end
    i = jumps_for.keys.length
    while(jumps_for.keys.length<n)
      i = i + 1 
      # p '+++++++'
      # p jumps_for
      # p 'components:'
      three_ago = jumps_for[i-3].map{|seq| seq.dup}
      three_ago.each{|seq| seq.push(3)}
      # p three_ago
      two_ago = jumps_for[i-2].map{|seq| seq.dup}
      two_ago.each{|seq| seq.push(2)}
      # p two_ago
      one_ago = jumps_for[i-1].map{|seq| seq.dup}
      one_ago.each{|seq| seq.push(1)}
      # p one_ago
      jumps_for[i]=(three_ago + two_ago + one_ago)
      # p '++++++'

    end
    jumps_for
  end
  def frog_hops_top_down(n)
    return @jumps_for[n].map{|seq| seq.dup} if (@jumps_for[n])
    # return @jumps_for[1].map{|seq| seq.dup} if (n == 1)
    # return @jumps_for[2].map{|seq| seq.dup} if (n == 2)
    # return @jumps_for[3].map{|seq| seq.dup} if (n == 3)

    frog_hops_top_down_helper(n)
    three_ago = frog_hops_top_down(n-3).each{|seq| seq.push(3)}
    two_ago = frog_hops_top_down(n-2).each{|seq| seq.push(2)}
    one_ago = frog_hops_top_down(n-1).each{|seq| seq.push(1)}
    @jumps_for[n]=(three_ago + two_ago + one_ago)
    return @jumps_for[n]
    # p '++++++'
  end

  def frog_hops_top_down_helper(n)

    false
  end

  def super_frog_hops(n, k)
    @jumps = @jumps = {
      1=>[[1]]
  }

    frog_builder(k<n ? k : n)
    if (@jumps[n]) 
      return @jumps[n].map{|seq| seq.dup} 
    end
    agos = []
    (1..k).each do |i|
      agos[i] = super_frog_hops(n-i,k).each{|seq| seq.push(i)}
    end
    @jumps[n] = agos.reduce([]){|sum,el| el ? sum.concat(el) : sum}
    # p @jumps

    return @jumps[n]
  end

  def frog_builder(k)
    while (@jumps.keys.length<k)
      @jumps[@jumps.length+1] = (nextKStep())
    end
    # p 'here'
    # p @jumps
  end
  def nextKStep
    stepptr = 1
    endptr = @jumps.keys.length
    nextEntry = []
    (1..@jumps.keys.length).each do |jump|
      stepcopy = @jumps[stepptr].map{|seq| seq.dup}
      # p'----'
      # p stepcopy
      
      stepcopy.each{|seq| seq.push(endptr)}
      # p stepcopy
      # p '----'
      nextEntry+=stepcopy
      stepptr = stepptr + 1
      endptr = endptr - 1
    end

    nextEntry.push([@jumps.keys.length+1])
        # p '==='
    # p nextEntry
    # p [@jumps.keys.length+1]
    # p '==='
    nextEntry
  end

  # find 

# knapsack of capacity 
  def knapsack(weights, values, capacity)
    # items = []
    # weights.length.times{|i| items.push(Item.new(weights[i],values[i]))}
    # knapsackI(items,capacity)
    p capacity
    p weights
    p @knapsack
    return 0 if (capacity==0 || weights.empty?)
    return @knapsack[capacity] if @knapsack[capacity]
    if (weights[0] > capacity)
      return knapsack(weights[1..-1],values[1..-1],capacity)
    else
      without = knapsack(weights[1..-1],values[1..-1],capacity)
      p without
      with = knapsack(weights[1..-1],values[1..-1],capacity-weights[0]) + values[0]
      p with
      @knapsack[capacity] = [with, without].max
    end
    @knapsack[capacity]

  end
  def knapsackI(items,capacity)
    
  end


  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end

class Item
  attr_accessor :weight,:value

  def initialize(weight, value)
   @weight = weight
   @value = value 
  end
end 
a = DynamicProgramming.new()
p '!!!!!!!'
p a.super_frog_hops(2, 2).sort
# p a.super_frog_hops(4, 3).sort
p a.super_frog_hops(2, 2).sort==[[1, 1], [2]] #== a.frog_hops_top_down(4).sort
p '!!!!'
p a.super_frog_hops(2, 5).sort
p a.super_frog_hops(2, 5).sort==([[1, 1], [2]])
p '!!!!!!!'
# p a.super_frog_hops(10, 4).sort
p a.super_frog_hops(10, 4).sort==  [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 2], [1, 1, 1, 1, 1, 1, 1, 2, 1], [1, 1, 1, 1, 1, 1, 1, 3], [1, 1, 1, 1, 1, 1, 2, 1, 1], [1, 1, 1, 1, 1, 1, 2, 2], [1, 1, 1, 1, 1, 1, 3, 1], [1, 1, 1, 1, 1, 1, 4], [1, 1, 1, 1, 1, 2, 1, 1, 1], [1, 1, 1, 1, 1, 2, 1, 2], [1, 1, 1, 1, 1, 2, 2, 1], [1, 1, 1, 1, 1, 2, 3], [1, 1, 1, 1, 1, 3, 1, 1], [1, 1, 1, 1, 1, 3, 2], [1, 1, 1, 1, 1, 4, 1], [1, 1, 1, 1, 2, 1, 1, 1, 1], [1, 1, 1, 1, 2, 1, 1, 2], [1, 1, 1, 1, 2, 1, 2, 1], [1, 1, 1, 1, 2, 1, 3], [1, 1, 1, 1, 2, 2, 1, 1], [1, 1, 1, 1, 2, 2, 2], [1, 1, 1, 1, 2, 3, 1], [1, 1, 1, 1, 2, 4], [1, 1, 1, 1, 3, 1, 1, 1], [1, 1, 1, 1, 3, 1, 2], [1, 1, 1, 1, 3, 2, 1], [1, 1, 1, 1, 3, 3], [1, 1, 1, 1, 4, 1, 1], [1, 1, 1, 1, 4, 2], [1, 1, 1, 2, 1, 1, 1, 1, 1], [1, 1, 1, 2, 1, 1, 1, 2], [1, 1, 1, 2, 1, 1, 2, 1], [1, 1, 1, 2, 1, 1, 3], [1, 1, 1, 2, 1, 2, 1, 1], [1, 1, 1, 2, 1, 2, 2], [1, 1, 1, 2, 1, 3, 1], [1, 1, 1, 2, 1, 4], [1, 1, 1, 2, 2, 1, 1, 1], [1, 1, 1, 2, 2, 1, 2], [1, 1, 1, 2, 2, 2, 1], [1, 1, 1, 2, 2, 3], [1, 1, 1, 2, 3, 1, 1], [1, 1, 1, 2, 3, 2], [1, 1, 1, 2, 4, 1], [1, 1, 1, 3, 1, 1, 1, 1], [1, 1, 1, 3, 1, 1, 2], [1, 1, 1, 3, 1, 2, 1], [1, 1, 1, 3, 1, 3], [1, 1, 1, 3, 2, 1, 1], [1, 1, 1, 3, 2, 2], [1, 1, 1, 3, 3, 1], [1, 1, 1, 3, 4], [1, 1, 1, 4, 1, 1, 1], [1, 1, 1, 4, 1, 2], [1, 1, 1, 4, 2, 1], [1, 1, 1, 4, 3], [1, 1, 2, 1, 1, 1, 1, 1, 1], [1, 1, 2, 1, 1, 1, 1, 2], [1, 1, 2, 1, 1, 1, 2, 1], [1, 1, 2, 1, 1, 1, 3], [1, 1, 2, 1, 1, 2, 1, 1], [1, 1, 2, 1, 1, 2, 2], [1, 1, 2, 1, 1, 3, 1], [1, 1, 2, 1, 1, 4], [1, 1, 2, 1, 2, 1, 1, 1], [1, 1, 2, 1, 2, 1, 2], [1, 1, 2, 1, 2, 2, 1], [1, 1, 2, 1, 2, 3], [1, 1, 2, 1, 3, 1, 1], [1, 1, 2, 1, 3, 2], [1, 1, 2, 1, 4, 1], [1, 1, 2, 2, 1, 1, 1, 1], [1, 1, 2, 2, 1, 1, 2], [1, 1, 2, 2, 1, 2, 1], [1, 1, 2, 2, 1, 3], [1, 1, 2, 2, 2, 1, 1], [1, 1, 2, 2, 2, 2], [1, 1, 2, 2, 3, 1], [1, 1, 2, 2, 4], [1, 1, 2, 3, 1, 1, 1], [1, 1, 2, 3, 1, 2], [1, 1, 2, 3, 2, 1], [1, 1, 2, 3, 3], [1, 1, 2, 4, 1, 1], [1, 1, 2, 4, 2], [1, 1, 3, 1, 1, 1, 1, 1], [1, 1, 3, 1, 1, 1, 2], [1, 1, 3, 1, 1, 2, 1], [1, 1, 3, 1, 1, 3], [1, 1, 3, 1, 2, 1, 1], [1, 1, 3, 1, 2, 2], [1, 1, 3, 1, 3, 1], [1, 1, 3, 1, 4], [1, 1, 3, 2, 1, 1, 1], [1, 1, 3, 2, 1, 2], [1, 1, 3, 2, 2, 1], [1, 1, 3, 2, 3], [1, 1, 3, 3, 1, 1], [1, 1, 3, 3, 2], [1, 1, 3, 4, 1], [1, 1, 4, 1, 1, 1, 1], [1, 1, 4, 1, 1, 2], [1, 1, 4, 1, 2, 1], [1, 1, 4, 1, 3], [1, 1, 4, 2, 1, 1], [1, 1, 4, 2, 2], [1, 1, 4, 3, 1], [1, 1, 4, 4], [1, 2, 1, 1, 1, 1, 1, 1, 1], [1, 2, 1, 1, 1, 1, 1, 2], [1, 2, 1, 1, 1, 1, 2, 1], [1, 2, 1, 1, 1, 1, 3], [1, 2, 1, 1, 1, 2, 1, 1], [1, 2, 1, 1, 1, 2, 2], [1, 2, 1, 1, 1, 3, 1], [1, 2, 1, 1, 1, 4], [1, 2, 1, 1, 2, 1, 1, 1], [1, 2, 1, 1, 2, 1, 2], [1, 2, 1, 1, 2, 2, 1], [1, 2, 1, 1, 2, 3], [1, 2, 1, 1, 3, 1, 1], [1, 2, 1, 1, 3, 2], [1, 2, 1, 1, 4, 1], [1, 2, 1, 2, 1, 1, 1, 1], [1, 2, 1, 2, 1, 1, 2], [1, 2, 1, 2, 1, 2, 1], [1, 2, 1, 2, 1, 3], [1, 2, 1, 2, 2, 1, 1], [1, 2, 1, 2, 2, 2], [1, 2, 1, 2, 3, 1], [1, 2, 1, 2, 4], [1, 2, 1, 3, 1, 1, 1], [1, 2, 1, 3, 1, 2], [1, 2, 1, 3, 2, 1], [1, 2, 1, 3, 3], [1, 2, 1, 4, 1, 1], [1, 2, 1, 4, 2], [1, 2, 2, 1, 1, 1, 1, 1], [1, 2, 2, 1, 1, 1, 2], [1, 2, 2, 1, 1, 2, 1], [1, 2, 2, 1, 1, 3], [1, 2, 2, 1, 2, 1, 1], [1, 2, 2, 1, 2, 2], [1, 2, 2, 1, 3, 1], [1, 2, 2, 1, 4], [1, 2, 2, 2, 1, 1, 1], [1, 2, 2, 2, 1, 2], [1, 2, 2, 2, 2, 1], [1, 2, 2, 2, 3], [1, 2, 2, 3, 1, 1], [1, 2, 2, 3, 2], [1, 2, 2, 4, 1], [1, 2, 3, 1, 1, 1, 1], [1, 2, 3, 1, 1, 2], [1, 2, 3, 1, 2, 1], [1, 2, 3, 1, 3], [1, 2, 3, 2, 1, 1], [1, 2, 3, 2, 2], [1, 2, 3, 3, 1], [1, 2, 3, 4], [1, 2, 4, 1, 1, 1], [1, 2, 4, 1, 2], [1, 2, 4, 2, 1], [1, 2, 4, 3], [1, 3, 1, 1, 1, 1, 1, 1], [1, 3, 1, 1, 1, 1, 2], [1, 3, 1, 1, 1, 2, 1], [1, 3, 1, 1, 1, 3], [1, 3, 1, 1, 2, 1, 1], [1, 3, 1, 1, 2, 2], [1, 3, 1, 1, 3, 1], [1, 3, 1, 1, 4], [1, 3, 1, 2, 1, 1, 1], [1, 3, 1, 2, 1, 2], [1, 3, 1, 2, 2, 1], [1, 3, 1, 2, 3], [1, 3, 1, 3, 1, 1], [1, 3, 1, 3, 2], [1, 3, 1, 4, 1], [1, 3, 2, 1, 1, 1, 1], [1, 3, 2, 1, 1, 2], [1, 3, 2, 1, 2, 1], [1, 3, 2, 1, 3], [1, 3, 2, 2, 1, 1], [1, 3, 2, 2, 2], [1, 3, 2, 3, 1], [1, 3, 2, 4], [1, 3, 3, 1, 1, 1], [1, 3, 3, 1, 2], [1, 3, 3, 2, 1], [1, 3, 3, 3], [1, 3, 4, 1, 1], [1, 3, 4, 2], [1, 4, 1, 1, 1, 1, 1], [1, 4, 1, 1, 1, 2], [1, 4, 1, 1, 2, 1], [1, 4, 1, 1, 3], [1, 4, 1, 2, 1, 1], [1, 4, 1, 2, 2], [1, 4, 1, 3, 1], [1, 4, 1, 4], [1, 4, 2, 1, 1, 1], [1, 4, 2, 1, 2], [1, 4, 2, 2, 1], [1, 4, 2, 3], [1, 4, 3, 1, 1], [1, 4, 3, 2], [1, 4, 4, 1], [2, 1, 1, 1, 1, 1, 1, 1, 1], [2, 1, 1, 1, 1, 1, 1, 2], [2, 1, 1, 1, 1, 1, 2, 1], [2, 1, 1, 1, 1, 1, 3], [2, 1, 1, 1, 1, 2, 1, 1], [2, 1, 1, 1, 1, 2, 2], [2, 1, 1, 1, 1, 3, 1], [2, 1, 1, 1, 1, 4], [2, 1, 1, 1, 2, 1, 1, 1], [2, 1, 1, 1, 2, 1, 2], [2, 1, 1, 1, 2, 2, 1], [2, 1, 1, 1, 2, 3], [2, 1, 1, 1, 3, 1, 1], [2, 1, 1, 1, 3, 2], [2, 1, 1, 1, 4, 1], [2, 1, 1, 2, 1, 1, 1, 1], [2, 1, 1, 2, 1, 1, 2], [2, 1, 1, 2, 1, 2, 1], [2, 1, 1, 2, 1, 3], [2, 1, 1, 2, 2, 1, 1], [2, 1, 1, 2, 2, 2], [2, 1, 1, 2, 3, 1], [2, 1, 1, 2, 4], [2, 1, 1, 3, 1, 1, 1], [2, 1, 1, 3, 1, 2], [2, 1, 1, 3, 2, 1], [2, 1, 1, 3, 3], [2, 1, 1, 4, 1, 1], [2, 1, 1, 4, 2], [2, 1, 2, 1, 1, 1, 1, 1], [2, 1, 2, 1, 1, 1, 2], [2, 1, 2, 1, 1, 2, 1], [2, 1, 2, 1, 1, 3], [2, 1, 2, 1, 2, 1, 1], [2, 1, 2, 1, 2, 2], [2, 1, 2, 1, 3, 1], [2, 1, 2, 1, 4], [2, 1, 2, 2, 1, 1, 1], [2, 1, 2, 2, 1, 2], [2, 1, 2, 2, 2, 1], [2, 1, 2, 2, 3], [2, 1, 2, 3, 1, 1], [2, 1, 2, 3, 2], [2, 1, 2, 4, 1], [2, 1, 3, 1, 1, 1, 1], [2, 1, 3, 1, 1, 2], [2, 1, 3, 1, 2, 1], [2, 1, 3, 1, 3], [2, 1, 3, 2, 1, 1], [2, 1, 3, 2, 2], [2, 1, 3, 3, 1], [2, 1, 3, 4], [2, 1, 4, 1, 1, 1], [2, 1, 4, 1, 2], [2, 1, 4, 2, 1], [2, 1, 4, 3], [2, 2, 1, 1, 1, 1, 1, 1], [2, 2, 1, 1, 1, 1, 2], [2, 2, 1, 1, 1, 2, 1], [2, 2, 1, 1, 1, 3], [2, 2, 1, 1, 2, 1, 1], [2, 2, 1, 1, 2, 2], [2, 2, 1, 1, 3, 1], [2, 2, 1, 1, 4], [2, 2, 1, 2, 1, 1, 1], [2, 2, 1, 2, 1, 2], [2, 2, 1, 2, 2, 1], [2, 2, 1, 2, 3], [2, 2, 1, 3, 1, 1], [2, 2, 1, 3, 2], [2, 2, 1, 4, 1], [2, 2, 2, 1, 1, 1, 1], [2, 2, 2, 1, 1, 2], [2, 2, 2, 1, 2, 1], [2, 2, 2, 1, 3], [2, 2, 2, 2, 1, 1], [2, 2, 2, 2, 2], [2, 2, 2, 3, 1], [2, 2, 2, 4], [2, 2, 3, 1, 1, 1], [2, 2, 3, 1, 2], [2, 2, 3, 2, 1], [2, 2, 3, 3], [2, 2, 4, 1, 1], [2, 2, 4, 2], [2, 3, 1, 1, 1, 1, 1], [2, 3, 1, 1, 1, 2], [2, 3, 1, 1, 2, 1], [2, 3, 1, 1, 3], [2, 3, 1, 2, 1, 1], [2, 3, 1, 2, 2], [2, 3, 1, 3, 1], [2, 3, 1, 4], [2, 3, 2, 1, 1, 1], [2, 3, 2, 1, 2], [2, 3, 2, 2, 1], [2, 3, 2, 3], [2, 3, 3, 1, 1], [2, 3, 3, 2], [2, 3, 4, 1], [2, 4, 1, 1, 1, 1], [2, 4, 1, 1, 2], [2, 4, 1, 2, 1], [2, 4, 1, 3], [2, 4, 2, 1, 1], [2, 4, 2, 2], [2, 4, 3, 1], [2, 4, 4], [3, 1, 1, 1, 1, 1, 1, 1], [3, 1, 1, 1, 1, 1, 2], [3, 1, 1, 1, 1, 2, 1], [3, 1, 1, 1, 1, 3], [3, 1, 1, 1, 2, 1, 1], [3, 1, 1, 1, 2, 2], [3, 1, 1, 1, 3, 1], [3, 1, 1, 1, 4], [3, 1, 1, 2, 1, 1, 1], [3, 1, 1, 2, 1, 2], [3, 1, 1, 2, 2, 1], [3, 1, 1, 2, 3], [3, 1, 1, 3, 1, 1], [3, 1, 1, 3, 2], [3, 1, 1, 4, 1], [3, 1, 2, 1, 1, 1, 1], [3, 1, 2, 1, 1, 2], [3, 1, 2, 1, 2, 1], [3, 1, 2, 1, 3], [3, 1, 2, 2, 1, 1], [3, 1, 2, 2, 2], [3, 1, 2, 3, 1], [3, 1, 2, 4], [3, 1, 3, 1, 1, 1], [3, 1, 3, 1, 2], [3, 1, 3, 2, 1], [3, 1, 3, 3], [3, 1, 4, 1, 1], [3, 1, 4, 2], [3, 2, 1, 1, 1, 1, 1], [3, 2, 1, 1, 1, 2], [3, 2, 1, 1, 2, 1], [3, 2, 1, 1, 3], [3, 2, 1, 2, 1, 1], [3, 2, 1, 2, 2], [3, 2, 1, 3, 1], [3, 2, 1, 4], [3, 2, 2, 1, 1, 1], [3, 2, 2, 1, 2], [3, 2, 2, 2, 1], [3, 2, 2, 3], [3, 2, 3, 1, 1], [3, 2, 3, 2], [3, 2, 4, 1], [3, 3, 1, 1, 1, 1], [3, 3, 1, 1, 2], [3, 3, 1, 2, 1], [3, 3, 1, 3], [3, 3, 2, 1, 1], [3, 3, 2, 2], [3, 3, 3, 1], [3, 3, 4], [3, 4, 1, 1, 1], [3, 4, 1, 2], [3, 4, 2, 1], [3, 4, 3], [4, 1, 1, 1, 1, 1, 1], [4, 1, 1, 1, 1, 2], [4, 1, 1, 1, 2, 1], [4, 1, 1, 1, 3], [4, 1, 1, 2, 1, 1], [4, 1, 1, 2, 2], [4, 1, 1, 3, 1], [4, 1, 1, 4], [4, 1, 2, 1, 1, 1], [4, 1, 2, 1, 2], [4, 1, 2, 2, 1], [4, 1, 2, 3], [4, 1, 3, 1, 1], [4, 1, 3, 2], [4, 1, 4, 1], [4, 2, 1, 1, 1, 1], [4, 2, 1, 1, 2], [4, 2, 1, 2, 1], [4, 2, 1, 3], [4, 2, 2, 1, 1], [4, 2, 2, 2], [4, 2, 3, 1], [4, 2, 4], [4, 3, 1, 1, 1], [4, 3, 1, 2], [4, 3, 2, 1], [4, 3, 3], [4, 4, 1, 1], [4, 4, 2]]