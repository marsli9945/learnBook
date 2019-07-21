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

function quick(array $arr)
{
    $len = count($arr);
    if ($len < 2) {
        return $arr;
    }

    quick_c($arr,0,$len-1);

    return $arr;
}

function quick_c(&$arr,$p,$r)
{
    if ($p > $r) {
        return;
    }

    $q = partition($arr,$p,$r);
    quick_c($arr,$p,$q-1);
    quick_c($arr,$q+1,$r);
}

function partition(&$arr,$p,$r)
{
    $pivot = $arr[$r];
    $i = $p;
    for ($j=$p; $j < $r; $j++) {
        if ($arr[$j] < $pivot) {
            swap($arr[$i],$arr[$j]);
            $i++;
        }
    }

    swap($arr[$i],$arr[$r]);

    return $i;
}

$arr = [5,8,7,1,9,11,62,87,215,751,421,21];
print_r(quick($arr));
