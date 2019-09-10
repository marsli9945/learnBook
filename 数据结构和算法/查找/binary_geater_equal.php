<?php

function binary(array $arr, int $num)
{
    $len = count($arr);
    if ($len < 2) {
        return $arr;
    }
    return binary_c($arr,$num,0,$len-1);
}

function binary_c($arr, $num, $low, $high)
{
    if ($low > $high) {
        return -1;
    }

    $mid = floor(($low + $high) / 2);
    if ($num > $arr[$mid]) {
        return binary_c($arr,$num,$mid+1,$high);
    } elseif ($num <= $arr[$mid]) {
        if ($mid == 0 || $arr[$mid-1] < $num) {
            return $mid;
        } else {
            return binary_c($arr,$num,$low,$mid-1);
        }
    }
}

$nums = [1, 2, 2, 4, 4, 5, 6];
$index = binary($nums, 3);
print $index;
