using System;
using System.Diagnostics;

public static class StopwatchExtensions
{
	public static long GetElapsedNanoseconds(this Stopwatch stopwatch)
	{
		return stopwatch.ElapsedTicks / (Stopwatch.Frequency / (1000L * 1000L));
	}
}

