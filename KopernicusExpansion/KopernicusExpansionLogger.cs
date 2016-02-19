using System;
using System.IO;
using System.Reflection;
using System.Collections.Generic;
using UnityEngine;

using Kopernicus;

namespace KopernicusExpansion
{
	public class KopernicusExpansionLogger : Logger
	{
		public static string KopELogDirectory
		{
			get{ return Logger.LogDirectory + "KopernicusExpansion/"; }
		}

		public KopernicusExpansionLogger(string loggerName = "KopernicusExpansion", string extension = ".log")
		{
			try
			{
				string logFile = KopELogDirectory + loggerName + extension;

				//manually set loggerStream using reflection
				var loggerStreamField = typeof(Logger).GetField ("loggerStream", BindingFlags.Instance | BindingFlags.NonPublic);
				loggerStreamField.SetValue (this, new StreamWriter (File.Create (logFile)));

				base.Log ("KopernicusExpansion logger created");
				base.Log ("");
			}
			catch (Exception e)
			{
				Utils.LogError ("Error creating KopernicusExpansionLogger:");
				Debug.LogException (e);
			}
		}

		public static void InitializeKopernicusExpansionLoggers()
		{
			try
			{
				//create new directory
				if(!Directory.Exists (KopELogDirectory))
					Directory.CreateDirectory (KopELogDirectory);
			}
			catch(Exception e)
			{
				Debug.LogException (e);
			}
		}
	}
}

