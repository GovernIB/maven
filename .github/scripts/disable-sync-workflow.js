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

  let disabledCount = 0;

  try {
    const repos = await octokit.repos.listForOrg({
      org: orgName,
      type: "all",
      per_page: 100
    });

    for (const repo of repos.data) {
      try {
        // Opcional: Comproveu si el workflow existeix abans d'intentar desactivar-lo
        // per evitar cridades innecessàries o registrar falsos positius.
        await octokit.actions.getWorkflow({
          owner: orgName,
          repo: repo.name,
          workflow_id: workflowFileName
        });

        // Si existeix, el desactivem
        await octokit.actions.disableWorkflow({
          owner: orgName,
          repo: repo.name,
          workflow_id: workflowFileName
        });

        console.log(`[ÈXIT] S'ha desactivat el workflow "${workflowFileName}" al repositori: ${repo.name}`);
        disabledCount++;

      } catch (err) {
        // Ignorem l'error 404 (significa que el repositori no té aquest workflow, cosa normal)
        if (err.status !== 404) {
          console.warn(`[AVÍS] No s'ha pogut processar el repositori ${repo.name}: ${err.message}`);
        }
      }
    }

    console.log(`\nProcés finalitzat. S'ha desactivat el workflow en un total de ${disabledCount} repositori(s).`);

  } catch (error) {
    console.error("Error general en llistar els repositoris:", error);
    process.exit(1);
  }
}

run();