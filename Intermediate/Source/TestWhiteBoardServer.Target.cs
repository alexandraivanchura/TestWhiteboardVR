using UnrealBuildTool;

public class TestWhiteBoardServerTarget : TargetRules
{
	public TestWhiteBoardServerTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.Latest;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Server;
		ExtraModuleNames.Add("TestWhiteBoard");
	}
}
