<?php

function swap(&$a,&$b)
{
    if ($a == $b) {
        return;
    }
    $a = $a ^ $b;
    $b = $a ^ $b;
    $a = $a ^ $b;
}

function selection(array $arr) {
    $len = count($arr);
    if($len < 2){
        return $arr;
    }

    for ($i = 0; $i < $len-1; $i++) {
        for ($j=$i+1; $j < $len; $j++) {
            if ($arr[$i] > $arr[$j]) {
                swap($arr[$i],$arr[$j]);
                $flag = true;
            }
        }
    }
    return $arr;
}

$arr = [5,8,7,1,9,11,62,87,215,751,421,21];
print_r(selection($arr));
