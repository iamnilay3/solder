﻿/*
	Copyright ©2002-2012 Daniel Bullington (dpbullington@gmail.com)
	Distributed under the MIT license: http://www.opensource.org/licenses/mit-license.php
*/

using System;

namespace Solder.Core.UnitTests.TestingInfrastructure
{
	[MockSingleTestAttibute(5)]
	[MockMultipleTestAttibute(10)]
	[MockMultipleTestAttibute(20)]
	public class MockTestAttributedClass
	{
		#region Constructors/Destructors

		public MockTestAttributedClass()
		{
		}

		#endregion
	}
}