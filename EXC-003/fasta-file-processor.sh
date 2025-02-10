 
num_seq=$(grep '>' $1 | wc -l)



sequence=$(awk '/>/ {if (seq) print seq; seq=""; next} {seq=seq $0} END {print seq}' "$1")


num_of_sequence_in_a_file=$(echo "$sequence" | wc -l)

 
total_length__seq=$(echo "$sequence" | awk '{print length}' | awk '{sum_seq += $1; count++} END {print sum_seq}')


length_of_seq=$(echo "$sequence" | awk '{print length}')


longest_seq=$(echo "$length_of_seq" | sort -n | tail -n 1)


shortest_seq=$(echo "$length_of_seq" | sort -n | head -n 1)

 
average_seq_length=$(echo "scale=2; $total_length__seq / $num_seq" | bc -l)


gc_con=$(echo "$sequence" | awk '{gc_count += gsub(/[GgCc]/, "", $1)} END {print gc_count}')


at_con=$(echo "$sequence" | awk '{at_count += gsub(/[AaTt]/, "", $1)} END {print at_count}')


sum_of_all_contents=$(echo "$at_con + $gc_con" | bc -l)



per_gc_content=$(echo "scale=2; ($gc_con / $sum_of_all_contents) * 100" | bc -l)


echo "FASTA File Statistics:"
echo "----------------------"
echo "Number of sequences: $num_seq"
echo "Total length of sequences: $total_length__seq"
echo "Length of the longest sequence: $longest_seq"
echo "Length of the shortest sequence: $shortest_seq"
echo "Average sequence length: $average_seq_length"
echo "GC Content (%): $per_gc_content"
echo $num_of_sequence_in_a_file









