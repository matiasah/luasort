local function medianOf3(t, low, high)
	
	local middle = math.floor( ( low + high ) / 2 )
	
	if t[middle] < t[low] then
		
		t[middle], t[low] = t[low], t[middle]
		
	end
	
	if t[high] < t[low] then
		
		t[high], t[low] = t[low], t[high]
		
	end
	
	if t[high] < t[middle] then
		
		t[high], t[middle] = t[middle], t[high]
		
	end
	
	t[middle], t[high - 1] = t[high - 1], t[middle]
	
	return t[high - 1]
	
end

local function partition(t, low, high, pivot)
	
	local left = low - 1
	local right = high + 1
	
	repeat
		
		repeat
			
			left = left + 1
			
		until t[left] >= pivot or left >= high
		
		repeat
			
			right = right - 1
			
		until t[right] <= pivot or right <= low
		
		if left >= right then
			
			break
			
		else
			
			t[left], t[right] = t[right], t[left]
			
		end
		
	until false
	
	return left
	
end

local function recQuickSort(t, left, right)
	
	local size = right - left + 1
	
	if size < 10 then
		
		table.insertionsort(t, left, right)
	
	else
		
		local pivot = medianOf3(t, left, right)
		local par = partition(t, left, right, pivot)
		
		recQuickSort(t, left, par - 1)
		recQuickSort(t, par, right)
		
	end
	
end

function table.insertionsort(t, left, right)
	
	local left = left or 1
	local right = right or #t
	
	for i = left + 1, right do
		
		local aux = t[i]
		local j = i
		
		while j > left and t[j - 1] >= aux do
			
			t[j] = t[j - 1]
			j = j - 1
			
		end
		
		t[j] = aux
		
	end
	
end

function table.quicksort(t)
	
	recQuickSort(t, 1, #t)
	
end
