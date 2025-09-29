using UnrealBuildTool;

public class TestWhiteBoardTarget : TargetRules
{
	public TestWhiteBoardTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.Latest;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Game;
		ExtraModuleNames.Add("TestWhiteBoard");
	}
}
