use tauri::{
  plugin::{Builder, TauriPlugin},
  Manager, Runtime,
};

pub use models::*;

#[cfg(desktop)]
mod desktop;
#[cfg(mobile)]
mod mobile;

mod commands;
mod error;
mod models;

pub use error::{Error, Result};

#[cfg(desktop)]
use desktop::Hark;
#[cfg(mobile)]
use mobile::Hark;

/// Extensions to [`tauri::App`], [`tauri::AppHandle`] and [`tauri::Window`] to access the hark APIs.
pub trait HarkExt<R: Runtime> {
  fn hark(&self) -> &Hark<R>;
}

impl<R: Runtime, T: Manager<R>> crate::HarkExt<R> for T {
  fn hark(&self) -> &Hark<R> {
    self.state::<Hark<R>>().inner()
  }
}

/// Initializes the plugin.
pub fn init<R: Runtime>() -> TauriPlugin<R> {
  Builder::new("hark")
    .invoke_handler(tauri::generate_handler![commands::ping])
    .setup(|app, api| {
      #[cfg(mobile)]
      let hark = mobile::init(app, api)?;
      #[cfg(desktop)]
      let hark = desktop::init(app, api)?;
      app.manage(hark);
      Ok(())
    })
    .build()
}
