{{- /*
  html.tpl — Trivy HTML report template

  This is the official template maintained by Aqua Security.
  To get the latest version, download it directly:

    curl -o templates/html.tpl \
      https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl

  Then run a scan with:
    trivy image \
      --format template \
      --template @templates/html.tpl \
      --output report.html \
      <image-name>
*/ -}}
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trivy Scan Report</title>
<style>
  body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Arial, sans-serif; margin: 20px; }
  h1 { color: #1F4E79; border-bottom: 2px solid #2E75B6; padding-bottom: 8px; }
  table { border-collapse: collapse; width: 100%; margin-bottom: 24px; }
  th, td { border: 1px solid #ddd; padding: 8px; text-align: left; vertical-align: top; }
  th { background-color: #f4f4f4; }
  .severity-CRITICAL { background-color: #d32f2f; color: white; font-weight: bold; padding: 2px 6px; border-radius: 3px; }
  .severity-HIGH     { background-color: #f57c00; color: white; font-weight: bold; padding: 2px 6px; border-radius: 3px; }
  .severity-MEDIUM   { background-color: #fbc02d; color: black; font-weight: bold; padding: 2px 6px; border-radius: 3px; }
  .severity-LOW      { background-color: #388e3c; color: white; font-weight: bold; padding: 2px 6px; border-radius: 3px; }
  .meta { color: #666; font-size: 0.9em; margin-bottom: 16px; }
</style>
</head>
<body>
<h1>Trivy Vulnerability Report</h1>
<div class="meta">
  Scan date: {{ now }}<br>
  Artifact: {{ . }}
</div>

{{- range . }}
<h2>{{ .Target }}</h2>
{{- if .Vulnerabilities }}
<table>
  <thead>
    <tr>
      <th>Package</th>
      <th>Vulnerability ID</th>
      <th>Severity</th>
      <th>Installed Version</th>
      <th>Fixed Version</th>
      <th>Title</th>
    </tr>
  </thead>
  <tbody>
    {{- range .Vulnerabilities }}
    <tr>
      <td>{{ .PkgName }}</td>
      <td><a href="{{ .PrimaryURL }}" target="_blank">{{ .VulnerabilityID }}</a></td>
      <td><span class="severity-{{ .Severity }}">{{ .Severity }}</span></td>
      <td>{{ .InstalledVersion }}</td>
      <td>{{ .FixedVersion }}</td>
      <td>{{ .Title }}</td>
    </tr>
    {{- end }}
  </tbody>
</table>
{{- else }}
<p>No vulnerabilities found.</p>
{{- end }}
{{- end }}
</body>
</html>
