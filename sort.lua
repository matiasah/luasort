local function medianOf3(t, low, high, comp)
	
	local middle = math.floor( ( low + high ) / 2 )
	
	if comp(t[middle], t[low]) then
		
		t[middle], t[low] = t[low], t[middle]
		
	end
	
	if comp(t[high], t[low]) then
		
		t[high], t[low] = t[low], t[high]
		
	end
	
	if comp(t[high], t[middle]) then
		
		t[high], t[middle] = t[middle], t[high]
		
	end
	
	t[middle], t[high - 1] = t[high - 1], t[middle]
	
	return t[high - 1]
	
end

local function partition(t, low, high, pivot, comp)
	
	local left = low - 1
	local right = high + 1
	
	repeat
		
		repeat
			
			left = left + 1
			
		until (not comp(t[left], pivot)) or left >= high
		
		repeat
			
			right = right - 1
			
		until (not comp(pivot, t[right])) or right <= low
		
		if left >= right then
			
			break
			
		else
			
			t[left], t[right] = t[right], t[left]
			
		end
		
	until false
	
	return left
	
end

local function insertionSort(t, left, right, comp)
	
	local left = left or 1
	local right = right or #t
	
	for i = left + 1, right do
		
		local aux = t[i]
		local j = i
		
		while j > left and not comp(t[j - 1], aux) do
			
			t[j] = t[j - 1]
			j = j - 1
			
		end
		
		t[j] = aux
		
	end
	
end

local function quickSort(t, left, right, comp)
	
	local size = right - left + 1
	
	if size < 10 then
		
		insertionSort(t, left, right, comp)
	
	else
		
		local pivot = medianOf3(t, left, right, comp)
		local par = partition(t, left, right, pivot, comp)
		
		quickSort(t, left, par - 1, comp)
		quickSort(t, par, right, comp)
		
	end
	
end

local function selectionSort(t, left, right, comp)
	
	for i = left, right do
		
		local aux = i
		
		for j = i, right do
			
			if comp(t[j], t[aux]) then
				
				aux = j
				
			end
			
		end
		
		t[i], t[aux] = t[aux], t[i]
		
	end
	
end

local function compare(a, b)
	
	return a < b
	
end

function table.insertionsort(t, comp)
	
	insertionSort(t, 1, #t, comp or compare)
	
end

function table.quicksort(t, comp)
	
	quickSort(t, 1, #t, comp or compare)
	
end

function table.selectionsort(t, comp)
	
	selectionSort(t, 1, #t, comp or compare)
	
end
