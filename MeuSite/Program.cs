using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using System.Text.Json;

var builder = WebApplication.CreateBuilder(args);

// Configure logging
builder.Logging.AddJsonConsole(options =>
{
    options.IncludeScopes = true;
    options.TimestampFormat = "yyyy-MM-dd HH:mm:ss.fff";
    options.JsonWriterOptions = new JsonWriterOptions
    {
        Indented = false
    };
    // Optionally, you could log to a file as well
    // Add a file provider for additional persistent logging
    // builder.Logging.AddFile(opts =>
    // {
    //     opts.IncludeScopes = true;
    //     opts.FormatterName = "json";
    // });
});

// Inject environment variables for Datadog
builder.Configuration["dd_env"] = "production";
builder.Configuration["dd_service"] = "meu_site";
builder.Configuration["dd_version"] = "1.0.0";

// Add services to the container
builder.Services.AddRazorPages();

var app = builder.Build();

// Configure the HTTP request pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();
app.UseAuthorization();

app.MapRazorPages();

app.Run("http://*:80/");
