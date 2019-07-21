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

function bubble(array &$arr): array
{
    $len = count($arr);
    if($len < 2){
        return $arr;
    }

    for ($i = 0; $i < $len; $i++) {
        $flag = false;
        for ($j=0; $j < $len - $i -1; $j++) {
            if ($arr[$j] > $arr[$j+1]) {
                swap($arr[$j],$arr[$j+1]);
                $flag = true;
            }
        }
        if (!$flag) {
            break;
        }
    }
    return $arr;
}

$arr = [5,8,7,1,9,11,62,87,215,751,421,21];
print_r(bubble($arr));
