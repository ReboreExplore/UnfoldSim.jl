"""
Pads array with specified value, length
padarray(arr, len, val)
"""
padarray(arr::Vector,len::Tuple,val) = padarray(padarray(arr,len[1],val),len[2],val)
function padarray(arr::Vector, len::Int, val)
		pad = fill(val, abs(len))
		arr = len > 0 ? vcat(arr, pad) : vcat(pad, arr)
	return arr
end



"""
Function to convert output similar to unfold (data, evts)
"""
function convert(eeg, onsets, design,n_ch,n_trial,n_subj;reshape=true)
	evt = UnfoldSim.generate(design)
	@debug size(eeg)
	if reshape
		if n_ch == 1
		data = eeg[:,]
		
		evt.latency = (onsets' .+ range(0,size(eeg,2)-1).*size(eeg,1) )'[:,]
		elseif n_subj == 1
			data = eeg
			evt.latency = onsets
		else # multi subject + multi channel
			data = eeg[:,:,]
			evt.latency = (onsets' .+ range(0,size(eeg,3)-1).*size(eeg,2) )'[:,]
		end
	else
		data = eeg
	end

	if :d ∈	names(evt)
    	select!(evt, Not([:dv]))
	end

	return data,evt
	
end

"""
Takes an array of 'm' target coordinate vector (size 3) (or vector of vectors) and a matrix (n-by-3) of all available positions, and returns an array of size 'm' containing the indices of the respective items in 'pos' that are nearest to each of the target coordinates.
"""
closest_srcs(coords_list::AbstractVector{<:AbstractVector}, pos)  = closest_srcs.(coords_list, Ref(pos))

function closest_srcs(coords::Vector{<:Real}, pos) 
	s = size(pos);
	dist = zeros(s[1]);
	diff = zeros(s[2]);
		for i=1:s[1] 
			for j=1:s[2]
				diff[j] = pos[i,j] - coords[j];
			end
			dist[i] = norm(diff);
		end
	return findmin(dist)[2]
	
	
end
