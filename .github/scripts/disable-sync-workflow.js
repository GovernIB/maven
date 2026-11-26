// .github/scripts/disable-sync-workflow.js
const { Octokit } = require("@octokit/rest");

const octokit = new Octokit({
  auth: process.env.ORG_PAT_TOKEN
});

async function run() {
  const orgName = process.env.TARGET_ORG;
  const workflowFileName = "sync-with-issue-status.yml";

  if (!orgName || !process.env.ORG_PAT_TOKEN) {
    console.error("Falten les variables d'entorn TARGET_ORG o ORG_PAT_TOKEN.");
    process.exit(1);
  }

  console.log(`Cercant repositoris a l'organització: ${orgName}...`);

  try {
    const repos = await octokit.repos.listForOrg({
      org: orgName,
      type: "all",
      per_page: 100
    });

    for (const repo of repos.data) {
      try {
        await octokit.actions.disableWorkflow({
          owner: orgName,
          repo: repo.name,
          workflow_id: workflowFileName
        });
        console.log(`[OK] Workflow "${workflowFileName}" desactivat a: ${repo.name}`);
      } catch (err) {
        if (err.status !== 404) {
          console.warn(`[AVÍS] No s'ha pogut desactivar a ${repo.name}: ${err.message}`);
        }
      }
    }
    console.log("Procés finalitzat.");
  } catch (error) {
    console.error("Error general en llistar els repositoris:", error);
    process.exit(1);
  }
}

run();