<?php

function insert(array $arr): array
{
    $len = count($arr);
    if ($len < 2) {
        return $arr;
    }

    for ($i=1; $i < $len; $i++) {
        $temp = $arr[$i];
        for ($j=$i-1; $j >= 0 && $arr[$j] > $temp; $j--) { 
            echo $j;
            $arr[$j+1] = $arr[$j];
        }
        $arr[$j+1] = $temp;
    }
    return $arr;
}

$arr = [5,8,7,1,9,11,62,87,215,751,421,21];
print_r(insert($arr));
