using UnrealBuildTool;

public class TestWhiteBoardEditorTarget : TargetRules
{
	public TestWhiteBoardEditorTarget(TargetInfo Target) : base(Target)
	{
		DefaultBuildSettings = BuildSettingsVersion.Latest;
		IncludeOrderVersion = EngineIncludeOrderVersion.Latest;
		Type = TargetType.Editor;
		ExtraModuleNames.Add("TestWhiteBoard");
	}
}
