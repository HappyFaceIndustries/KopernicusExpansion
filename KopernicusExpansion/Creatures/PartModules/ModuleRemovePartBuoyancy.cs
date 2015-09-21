using System;

namespace KopernicusExpansion.Creatures.PartModules
{
	public class ModuleRemovePartBuoyancy : PartModule
	{
		public override void OnStart (StartState state)
		{
			if(part.partBuoyancy != null)
				Destroy (part.partBuoyancy);
		}
	}
}

