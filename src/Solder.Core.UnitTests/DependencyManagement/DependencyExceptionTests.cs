/*
	Copyright �2002-2012 Daniel Bullington (dpbullington@gmail.com)
	Distributed under the MIT license: http://www.opensource.org/licenses/mit-license.php
*/

using System;

using NUnit.Framework;

using Solder.Core.DependencyManagement;

namespace Solder.Core.UnitTests.DependencyManagement
{
	[TestFixture]
	public class DependencyExceptionTests
	{
		#region Constructors/Destructors

		public DependencyExceptionTests()
		{
		}

		#endregion

		#region Methods/Operators

		[Test]
		public void ShouldCreateTest()
		{
			DependencyException exception;

			exception = new DependencyException("msg");

			Assert.IsNotNull(exception);
			Assert.IsNotNull(exception.Message);
			Assert.AreEqual("msg", exception.Message);
		}

		#endregion
	}
}