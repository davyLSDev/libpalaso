﻿using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using Palaso.WritingSystems;

namespace Palaso.UI.WindowsForms.WritingSystems
{
	class WritingSystemDefinitionVariantHelper
	{
		public static string ValidVariantString(string unknownString)
		{
			// var1-var2-var3
			// var1-privateUse1-x-privateUse2
			unknownString = unknownString.Trim();
			unknownString = Regex.Replace(unknownString, @"[ ,.]", "-");
			unknownString = Regex.Replace(unknownString, @"-+", "-");
			var tokens = unknownString.Split('-');
			var variants = new List<string>();
			var privateUse = new List<string>();
			bool haveSeenX = false;

			foreach (var token in tokens)
			{
				if (token == "x")
				{
					haveSeenX = true;
					continue;
				}
				if (!haveSeenX && StandardTags.IsValidRegisteredVariant(token))
				{
					variants.Add(token);
				}
				else
				{
					privateUse.Add(token);
				}
			}
			string combinedVariant = String.Join("-", variants.ToArray());
			string combinedPrivateUse = String.Join("-", privateUse.ToArray());
			string variantString = combinedVariant;
			if (!String.IsNullOrEmpty(combinedPrivateUse))
			{
				variantString = "x-" + combinedPrivateUse;
				if (!String.IsNullOrEmpty(combinedVariant))
				{
					variantString = combinedVariant + "-" + variantString;
				}
			}
			return variantString;
		}
	}
}