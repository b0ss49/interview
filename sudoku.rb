dimx,dimy = gets.split.map(&:to_i)
arr = Array.new(dimy,Array.new(dimx))
for i in (0...dimy)
	arr[i] = gets.split.map(&:to_i)
end

def isSafe(arr,temp,i)
	
		for x in (0...arr.length)
			#check col
			for k in (0...arr.length)
				if k!=i and arr[k][x]==temp[x] 
					return false
				end
			end
			begin_scope_x = 0
			begin_scope_y = 0
			end_scope_x = 0
			end_scope_y = 0
			#puts "XXXX"
			#puts "#{begin_scope_x} #{begin_scope_y} #{end_scope_x} #{end_scope_y}"
			arr_sqrt = Math.sqrt(arr.length).to_i
			
			if i<arr_sqrt
				begin_scope_y = 0
				end_scope_y = arr_sqrt-1
			else
				blockY = (i/arr_sqrt)+1
				begin_scope_y = blockY*arr_sqrt - arr_sqrt
				end_scope_y = blockY*arr_sqrt-1
			end
			blockX = (x/arr_sqrt)+1
			begin_scope_x = (blockX*arr_sqrt)-arr_sqrt
			end_scope_x = blockX*arr_sqrt-1
			puts "Checking: [#{begin_scope_x}, #{end_scope_x}] [#{begin_scope_y}, #{end_scope_y}]"
					for grr in (begin_scope_y..end_scope_y)
						for j in (begin_scope_x..end_scope_x)
							if ((grr==i && j!=x)||(j==x && grr!=i)) && arr[grr][j]==temp[x]
								#puts "arr: #{arr[grr][j]} temp: #{temp[x]} grr: #{grr} j: #{j} i: #{i} x: #{x}"
								#puts "False"
								#puts "#{temp}"
								#puts "******************"
								return false
							end
						end
					end
				
		end
	
	puts "return"
	return true
end

def generate_temp(arr,i)
	unused = Array(1..arr.length)
	temp = Array.new(arr.length,0)

	for j in (0...arr.length)
		if arr[i][j]>0
			temp[j] = arr[i][j]
			unused.delete(temp[j])
		end
	end
	for j in (0...arr.length)
		#puts "J: #{j}"
		#puts "arr: #{arr[i][j]}"
		if arr[i][j]==0
			loop do 
				#not return until temp is not in arr[i] and temp is not used
				temp[j] = Random.new.rand(1..arr.length)
				#puts "tempJ: #{temp[j]}"
				break if unused.include?(temp[j])
			end
			unused.delete(temp[j])
		j+=1
		end
		
	end
	return temp
end

def calc(arr)
	tried = Array.new(arr.length,Array.new(2))
	arr_temp = arr
	k=0
	while k<arr.length
		puts "k = #{k}"
		temp = generate_temp(arr,k)
		loop do
			timeout = 0
			loop do
				temp = generate_temp(arr,k)
				break if !tried[k].include?(temp)
				if timeout>1000
					k=0
				end
				timeout+=1
				puts "#{timeout}"
			end 
			puts "#{k} Generate #{temp}"
			break if isSafe(arr_temp,temp,k)
			tried[k].push(temp)
		end
		arr_temp[k] = temp
		k+=1
		puts "Array: #{arr}"
	end

	return arr_temp
end

arr = calc(arr)
puts "#{arr}"