import * as assert from "assert";
import * as vscode from "vscode";

suite("Extension", () => {
	suiteSetup(() => {
		vscode.extensions.getExtension("grg.template")!.activate();
	});
	test("", () => {
		assert.deepStrictEqual("", "");
	});
});
