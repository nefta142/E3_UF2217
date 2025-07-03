<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

  <xsl:output method="html" encoding="UTF-8" indent="yes"/>

  <!-- Claves corregidas y separadas -->
  <xsl:key name="departamentosUnicosEmpleados" match="empleado" use="departamento"/>
  <xsl:key name="departamentosUnicosConsultores" match="consultor" use="departamento"/>

  <xsl:template match="/registroPersonal">
    <html>
      <head>
        <title>Empresa</title>
        <meta charset="UTF-8"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet"/>
        <link rel="stylesheet" href="https://cdn.datatables.net/1.13.6/css/dataTables.bootstrap5.min.css"/>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet"/>
        <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/jquery.dataTables.min.js"></script>
        <script src="https://cdn.datatables.net/1.13.6/js/dataTables.bootstrap5.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
          <![CDATA[
            $(document).ready(function(){
              var tablaEmpleados = $('#tablaEmpleados').DataTable();
              var tablaConsultores = $('#tablaConsultores').DataTable();
              $('#tablaDepartamentos').DataTable();

              $('#filtroDepartamento').on('change', function () {
                tablaEmpleados.column(5).search(this.value).draw();
              });

              $('#filtrodepartamento').on('change', function () {
                tablaConsultores.column(5).search(this.value).draw();
              });
            });
          ]]>
        </script>
      </head>
      <body class="bg-light">
        <div class="container py-5">
          <h1 class="mb-4 text-center text-primary">Información de la Empresa</h1>

          <!-- Navegación de pestañas -->
          <ul class="nav nav-tabs mb-3" id="tabsEmpresa" role="tablist">
            <li class="nav-item" role="presentation">
              <button class="nav-link active" id="empleados-tab" data-bs-toggle="tab" data-bs-target="#empleados" type="button" role="tab">
                <i class="bi bi-people-fill"></i> Empleados
              </button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="consultores-tab" data-bs-toggle="tab" data-bs-target="#consultores" type="button" role="tab">
                <i class="bi bi-person-badge-fill"></i> Consultores
              </button>
            </li>
            <li class="nav-item" role="presentation">
              <button class="nav-link" id="departamentos-tab" data-bs-toggle="tab" data-bs-target="#departamentos" type="button" role="tab">
                <i class="bi bi-journal-bookmark-fill"></i> Departamentos
              </button>
            </li>
          </ul>

          <!-- Contenido de las pestañas -->
          <div class="tab-content" id="tabsContenido">

            <!-- Empleados -->
            <div class="tab-pane fade show active" id="empleados" role="tabpanel">
              <label for="filtroDepartamento" class="form-label">Filtrar por departamento:</label>
              <select id="filtroDepartamento" class="form-select mb-3">
                <option value="">-- Todos --</option>
                <xsl:for-each select="empleados/empleado[generate-id() = generate-id(key('departamentosUnicosEmpleados', departamento)[1])]">
                  <xsl:sort select="departamento"/>
                  <option>
                    <xsl:value-of select="departamento"/>
                  </option>
                </xsl:for-each>
              </select>

              <table id="tablaEmpleados" class="table table-striped">
                <thead class="table-primary">
                  <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Sexo</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Departamento</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="empleados/empleado">
                    <tr>
                      <td><xsl:value-of select="@cod"/></td>
                      <td><xsl:value-of select="nombre"/></td>
                      <td><xsl:value-of select="sexo"/></td>
                      <td><xsl:value-of select="contacto/email"/></td>
                      <td><xsl:value-of select="contacto/telefono"/></td>
                      <td><xsl:value-of select="departamento"/></td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>

            <!-- Consultores -->
            <div class="tab-pane fade" id="consultores" role="tabpanel">
              <label for="filtrodepartamento" class="form-label">Filtrar por departamento:</label>
              <select id="filtrodepartamento" class="form-select mb-3">
                <option value="">-- Todos --</option>
                <xsl:for-each select="consultores/consultor[generate-id() = generate-id(key('departamentosUnicosConsultores', departamento)[1])]">
                  <xsl:sort select="departamento"/>
                  <option>
                    <xsl:value-of select="departamento"/>
                  </option>
                </xsl:for-each>
              </select>

              <table id="tablaConsultores" class="table table-striped">
                <thead class="table-secondary">
                  <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Sexo</th>
                    <th>Email</th>
                    <th>Teléfono</th>
                    <th>Departamento</th>
                    <th>Empresa Externa</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="consultores/consultor">
                    <tr>
                      <td><xsl:value-of select="@cod"/></td>
                      <td><xsl:value-of select="nombre"/></td>
                      <td><xsl:value-of select="sexo"/></td>
                      <td><xsl:value-of select="contacto/email"/></td>
                      <td><xsl:value-of select="contacto/telefono"/></td>
                      <td><xsl:value-of select="departamento"/></td>
                      <td><xsl:value-of select="empresaExterna"/></td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>

            <!-- Departamentos -->
            <div class="tab-pane fade" id="departamentos" role="tabpanel">
              <table id="tablaDepartamentos" class="table table-striped">
                <thead class="table-success">
                  <tr>
                    <th>Código</th>
                    <th>Nombre</th>
                    <th>Director</th>
                    <th>Empleados</th>
                    <th>Dirección</th>
                  </tr>
                </thead>
                <tbody>
                  <xsl:for-each select="departamentos/departamento">
                    <tr>
                      <td><xsl:value-of select="@cod"/></td>
                      <td><xsl:value-of select="nombre"/></td>
                      <td><xsl:value-of select="director"/></td>
                      <td>
                        <xsl:for-each select="empleados/empleado">
                          <span class="badge bg-primary me-1">
                            <xsl:value-of select="@cod"/>
                          </span>
                        </xsl:for-each>
                      </td>
                      <td>
                        <xsl:value-of select="direccion/calle"/>,
                        <xsl:value-of select="direccion/ciudad"/>,
                        <xsl:value-of select="direccion/codigoPostal"/>
                      </td>
                    </tr>
                  </xsl:for-each>
                </tbody>
              </table>
            </div>

          </div>
        </div>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
