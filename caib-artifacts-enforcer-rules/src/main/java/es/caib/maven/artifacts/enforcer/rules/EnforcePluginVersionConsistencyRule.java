package es.caib.maven.artifacts.enforcer.rules;

import org.apache.maven.enforcer.rule.api.EnforcerRule;
import org.apache.maven.enforcer.rule.api.EnforcerRuleException;
import org.apache.maven.enforcer.rule.api.EnforcerRuleHelper;
import org.apache.maven.project.MavenProject;

/**
 * 
 * @author anadal
 * 7 oct 2025 10:23:24
 */
@SuppressWarnings("deprecation")
public class EnforcePluginVersionConsistencyRule implements EnforcerRule {

    @Override
    public void execute(EnforcerRuleHelper helper) throws EnforcerRuleException {
        try {
            MavenProject project = (MavenProject) helper.evaluate("${project}");

            if (project.getBuild() == null || project.getBuild().getPluginManagement() == null
                    || project.getBuild().getPluginManagement().getPlugins() == null) {
                return;
            }

            project.getBuild().getPlugins().forEach(plugin -> {
                project.getBuild().getPluginManagement().getPlugins().forEach(managed -> {
                    if (plugin.getGroupId().equals(managed.getGroupId())
                            && plugin.getArtifactId().equals(managed.getArtifactId())) {

                        String v1 = plugin.getVersion();
                        String v2 = managed.getVersion();
                        if (v1 != null && v2 != null && !v1.equals(v2)) {
                            throw new RuntimeException("Plugin '" + plugin.getArtifactId() + "' usa versión " + v1
                                    + " distinta de la definida en pluginManagement (" + v2 + ")");
                        }
                    }
                });
            });
        } catch (Exception e) {
            throw new EnforcerRuleException("Error verificando versiones de plugins: " + e.getMessage(), e);
        }
    }

    @Override
    public String getCacheId() {
        return null;
    }

    @Override
    public boolean isCacheable() {
        return false;
    }

    @Override
    public boolean isResultValid(EnforcerRule rule) {
        return false;
    }
}
