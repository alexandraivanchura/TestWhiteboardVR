using UnrealBuildTool;

public class TestWhiteBoardClientTarget : TargetRules
{
	public TestWhiteBoardClientTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.Latest;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Client;
		ExtraModuleNames.Add("TestWhiteBoard");
	}
}
