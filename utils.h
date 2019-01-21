#pragma once

#include <algorithm>
#include <cmath>
#include <cstdio>

inline int tweak(int val)
{
	int t = (rand() % 16) / 15;

	return std::max(val + t, 0);
}
