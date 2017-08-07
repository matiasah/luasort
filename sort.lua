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

local hashFunctions = {}

function hashFunctions.number(Number)
	
	return Number
	
end

function hashFunctions.string(String)
	
	local Hash = 0
	
	for i = 1, #String do
		
		Hash = Hash * 31 + String:byte(i)
		
	end
	
	return Hash
	
end

function table.countingsort(Table, hashFunction)
	
	if not hashFunction then
		
		local Index, Value = next(Table)
		
		if not Value then
			
			return nil
			
		end
		
		hashFunction = hashFunctions[type(Value)]
		
	end
	
	local Max
	local Min
	local Hash = {}
	local Copy = {}
	
	for i = 1, #Table do
		
		local Value = Table[i]
		
		if not Hash[Value] then
			
			Hash[Value] = hashFunction(Value)
			
		end
		
		Max = math.max(Hash[Value], Max or Hash[Value])
		Min = math.min(Hash[Value], Min or Hash[Value])
		Copy[i] = Value
		
	end
	
	local CountingArray = {}
	
	for i = 1, #Table do
		
		local Index = Hash[Table[i]] - Min + 1
		local Count = CountingArray[Index]
		
		if not Count then
			
			Count = 0
			
		end
		
		CountingArray[Index] = Count + 1
		
	end
	
	local Total = 1
	
	for i = 1, Max - Min + 1 do
		
		local OldCount = CountingArray[i]
		
		if not OldCount then
			
			OldCount = 0
			
		end
		
		CountingArray[i]	= Total
		Total					= Total + OldCount
		
	end
	
	for i = 1, #Copy do
		
		local Index = Hash[Copy[i]] - Min + 1
		local TableIndex = CountingArray[Index]
		
		Table[TableIndex]		= Copy[i]
		CountingArray[Index]	= TableIndex + 1
		
	end
	
end

function table.countingsort2(Table, hashFunction)
	
	if not hashFunction then
		
		local Index, Value = next(Table)
		
		if not Value then
			
			return nil
			
		end
		
		hashFunction = hashFunctions[type(Value)]
		
	end
	
	local Max
	local Min
	local Hash = {}
	local Copy = {}
	
	for i = 1, #Table do
		
		local Value = Table[i]
		
		if not Hash[Value] then
			
			Hash[Value] = hashFunction(Value)
			
		end
		
		Max = math.max(Hash[Value], Max or Hash[Value])
		Min = math.min(Hash[Value], Min or Hash[Value])
		Copy[i] = Value
		
	end
	
	local CountingArray = {}
	
	for i = 1, #Table do
		
		local Index = Hash[Table[i]] - Min + 1
		local Count = CountingArray[Index]
		
		if not Count then
			
			Count = 0
			
		end
		
		CountingArray[Index] = Count + 1
		
	end
	
	local Total = 1
	
	for i = 1, Max - Min + 1 do
		
		local OldCount = CountingArray[i]
		
		if not OldCount then
			
			OldCount = 0
			
		end
		
		CountingArray[i]	= Total
		Total					= Total + OldCount
		
	end
	
	for i = 1, #Copy do
		
		local Index = Hash[Copy[i]] - Min + 1
		local TableIndex = CountingArray[Index]
		
		Table[TableIndex]		= Copy[i]
		CountingArray[Index]	= TableIndex + 1
		
	end
	
end

function table.distributionSort(Table, Start, End, hashFunction, comp)
	
	if not hashFunction then
		
		local Index, Value = next(Table)
		
		if not Value then
			
			return nil
			
		end
		
		hashFunction = hashFunctions[type(Value)]
		
	end
	
	local Start = Start or 1
	local End = End or #Table
	
	local Max
	local Min
	local Hash = {}
	
	for i = Start, End do
		
		local Value = Table[i]
		
		if not Hash[Value] then
			
			Hash[Value] = hashFunction(Value)
			
		end
		
		Max = math.max(Hash[Value], Max or Hash[Value])
		Min = math.min(Hash[Value], Min or Hash[Value])
		
	end
	
	local Distribution = {}
	local DistributionPos = {}
	local DistributionCount = {}
	local DistributionLength = math.ceil( math.sqrt( End - Start + 1 ) )
	local Factor = DistributionLength / ( Max - Min + 1 )
	
	for i = Start, End do
		
		local HashIndex = Hash[Table[i]] - Min
		local Index = math.floor( HashIndex * Factor ) + 1
		
		Distribution[ Index ] = ( Distribution[ Index ] or 0 ) + 1
		
	end
	
	local Accum = Start
	
	for i = 1, DistributionLength + 1 do
		
		DistributionCount[i] = Distribution[i] or 0
		DistributionPos[i] = Accum
		Distribution[i] = Accum
		
		Accum = Accum + DistributionCount[i]
		
	end
	
	for DistributionIndex = 1, DistributionLength do
		
		for i = Distribution[DistributionIndex], Distribution[DistributionIndex + 1] - 1 do
			
			local HashIndex = Hash[Table[i]] - Min
			local Index = math.floor( HashIndex * Factor ) + 1
			
			while Index ~= DistributionIndex do
				
				local AuxIndex = DistributionPos[Index]
				local Aux = Table[AuxIndex]
				
				DistributionPos[Index] = DistributionPos[Index] + 1
				
				Table[AuxIndex] = Table[i]
				Table[i] = Aux
				
				HashIndex = Hash[Table[i]] - Min
				Index = math.floor( HashIndex * Factor ) + 1
				
			end
			
		end
		
		if DistributionCount[DistributionIndex] > 1 then
			
			if DistributionCount[DistributionIndex] < 10 then
				
				insertionSort(Table, Distribution[DistributionIndex], Distribution[DistributionIndex] + DistributionCount[DistributionIndex] - 1, comp or compare)
				
			else
				
				table.distributionSort(Table, Distribution[DistributionIndex], Distribution[DistributionIndex] + DistributionCount[DistributionIndex] - 1, hashFunction, comp or compare)
				
			end
			
		end
		
	end
	
	return nil
	
end