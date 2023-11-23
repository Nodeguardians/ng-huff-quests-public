/**
 * These tests check that noir-directory.json and quest-to-test.json are correctly configured for public deployment.
 * Specifically:
 *    1. huff-directory.json should contain all quests with matching version numbers
 *    2. All entries in each files-to-test.json should be valid paths
 *    3. All public contracts and scripts (i.e. in "/_contracts") not in files-to-test.json must match their private counterparts
 */

"use strict";
const { assert } = require("chai");
const fs = require("fs");
const path = require("path");
const { equalFiles, getFiles, readJson } = require("./helpers/filehelper.js");

const directory = require("../campaigns/huff-directory.json");

const campaignDirectoryPath = path.resolve(__dirname, "..", "campaigns");

/**
* Asserts files in `contracts` matches files in `_contracts`.
* Excludes files found in toExclude.
*/
async function compareFiles(questPath, toExclude) {

  const allFiles = await getFiles(questPath);
  
  const solutionFiles = allFiles.filter(
    f => f.startsWith("contracts")
  );

  for (const solutionFile of solutionFiles) {

    if (toExclude.some(solutionFile => solutionFile.endsWith(solutionFile))) { continue; }

    const expectedUserFile = solutionFile
      .replace("contracts", "_contracts");
    
    const fullTemplatePath = path.resolve(questPath, expectedUserFile);
    const fullSolutionPath = path.resolve(questPath, solutionFile);

    assert(
      equalFiles(fullTemplatePath, fullSolutionPath), 
      `User contract mismatch with solution: ${solutionFile}`
    );

  }

}

describe("Deployment Configuration Test", async function() {

  it("huff-directory.json should be correctly configured", async function() {

    for (const campaign of directory) {

      const campaignPath = path.resolve(campaignDirectoryPath, campaign.name);

      for (const quest of campaign.quests) {
        const questPath = path.resolve(campaignPath, quest.name);

        // Test valid name
        assert(fs.existsSync(questPath), `${questPath} does not exist`);

        // Test valid version
        const jsonVersion = readJson(path.resolve(questPath, "package.json")).version;
        assert(jsonVersion == quest.version, `"${quest.name}" has mismatched versions in package.json`);

        // Test valid type
        assert(
            quest.type == "ctf" || quest.type == "build", 
            `${quest.name} has an invalid type`
        );

        // Test valid number of parts
        const lastPartPath = path.join(questPath, `description/part${quest.parts}.md`);
        const invalidPartPath = path.join(questPath, `description/part${quest.parts + 1}.md`);
        assert(
            fs.existsSync(lastPartPath) && !fs.existsSync(invalidPartPath),
            `${quest.name} might have an incorrect number of parts`
        );

      }

      const numQuests = fs.readdirSync(campaignPath, { withFileTypes: true })
        .filter(entry => entry.isDirectory() && entry.name != "media")
        .length;

      assert(
        numQuests == campaign.quests.length, 
        `"${campaign.name}" has mismatched number of quests`
      );

    }

  });

  it("files-to-test.json should be correctly configured", async function() {

    for (const campaign of directory) {

      for (const quest of campaign.quests) {

        const questPath = path.resolve(campaignDirectoryPath, campaign.name, quest.name);

        // If quest is CTF, skip
        if (quest.type == "ctf") { continue; }

        // Ensure build quest has files-to-test.json
        const filesToTestPath = path.resolve(questPath, "files-to-test.json");
        assert(fs.existsSync(filesToTestPath), `${quest.name} is missing files-to-test.json`); 

        const filesToTest = require(filesToTestPath)
          .map(fileName => path.resolve(questPath, fileName));

        for (const filePath of filesToTest) {

          assert(fs.existsSync(filePath), `Invalid file path: ${filePath} in ${filesToTestPath}`);
          assert(
            filePath.endsWith(".huff"), 
            `File must be *.huff: ${filePath} in ${filesToTestPath}`
          );
        }

        // Test that all other common contracts/scripts 
        // between public and private folder share the same code
        // (This ensures there is no missing file in files-to-test.json)
        await compareFiles(questPath, ["lib.cairo", ...filesToTest]);

      }
    }

  });

});