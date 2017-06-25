let project = new Project('Showcase');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addSources('../Plume/Sources');
resolve(project);
