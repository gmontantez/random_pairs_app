def sample(array)
	#array.shuffle[0..x] #print sample(["Aaron", "Anna", "Gail", "Gabrielle", "Scott", "Rob"], 1)
    sliced_pairs = array.shuffle.each_slice(2).to_a
	if array.length % 2 == 1
		sliced_pairs[-2].push(sliced_pairs.pop.join)
		sliced_pairs
	else
		sliced_pairs
	end
    	
end

# print sample(["Gail", "Gabby", "Anna", "Scott"])