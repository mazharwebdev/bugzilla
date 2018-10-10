class DocsignsController < ApplicationController
  
  def index
    @docsign = Docusign.all
    @my_hash = {} 
    @docsign.each_with_index do |d,index|
      # get Status
      chkstatus = status_env(d.envelopeId)

      name = chkstatus['signers'][0]['name']
      email = chkstatus['signers'][0]['email'] 
      url = embedded_signing(d.envelopeId , name ,email)
      
      @my_hash[index] = Hash.new()
      @my_hash[index]["status"] = chkstatus
      @my_hash[index]["url"] = url
      @my_hash[index]["enveloped_id"] = d.envelopeId

      # Request for File Path
      get_doc(d.envelopeId)
    end 
    @pdf_filename = File.join(Rails.root, 'public','test.pdf')
  end

  # Sending Document and create Envelope
  def sending_doc
    # create Connection
    fileName = params['doc']

    client = DocusignRest::Client.new 
    # File Path   
    file = File.join(Rails.root, 'public',fileName)

    @response = client.create_envelope_from_document(
      email: {
        subject: params['myform']['email_subject'],
        body: params['myform']['email_body']
      },
      # If embedded is set to true  in the signers array below, emails don't go out
      # and you can embed the signature page in an iFrame by using the
      # get_recipient_view method
      signers: [
        {
          embedded: true,
          name: params['myform']['name'],
          email: params['myform']['email'],
        }
      ],
      files: [
        { path: file, name: fileName },
      ],
      status: 'sent'
    )

    @response #the response is a parsed JSON string
    @dsign = Docusign.new
    @dsign.envelopeId = @response['envelopeId']
    @dsign.uri = @response['uri']
    @dsign.statusDateTime = @response['statusDateTime']
    @dsign.status = @response['status']
    
    if @response['status'] == 'sent'

      if @dsign.save!
       flash[:success] = 'Successfully Created'
       redirect_to docsigns_path
      else
       flash[:warning] = @response['message']
       redirect_to new_docsign_path
      end
    else
      flash[:warning] = @response['message']
      redirect_to new_docsign_path
    end  

  end  

  # Status Enveolpe
  def status_env(en_id)
   client = DocusignRest::Client.new
    response = client.get_envelope_recipients(
      envelope_id: en_id,
      include_tabs: true,
      include_extended: true
    )
    response

  end

  # get Document against specific Envlope ID
  def get_doc(en_id)
    filename = 'public/singed_doc/' + en_id + '.pdf'
    client = DocusignRest::Client.new
    @doc_response = client.get_document_from_envelope(
      envelope_id: en_id,
      document_id: 1,
      local_save_path: "#{Rails.root.join(filename)}"
    )
    @doc_response

  end 

  # Sending Document and create Envelope
  def not_sending_doc
    # create Connection
    client = DocusignRest::Client.new 
    # File Path   
    file = File.join(Rails.root, 'public','test.pdf')

    @response = client.create_envelope_from_document(
      email: {
        subject: 'Test email subject',
        body: 'This is the email body.'
      },
      # If embedded is set to true  in the signers array below, emails don't go out
      # and you can embed the signature page in an iFrame by using the
      # get_recipient_view method
      signers: [
        {
          embedded: true,
          name: 'Test Guy',
          email: 'testfbcon@gmail.com',
        }
      ],
      files: [
        { path: file, name: 'test.pdf' },
      ],
      status: 'sent'
    )

    @response #the response is a parsed JSON string

  end 

  def embedded_signing(env_id, name, email)
    client = DocusignRest::Client.new
    @url = client.get_recipient_view(
      envelope_id: env_id,
      name: name,
      email: email,
      return_url: "http://localhost:3000/docsigns/docusign_response"
    )
  end

  def docusign_response
    utility = DocusignRest::Utility.new
    if params[:event] == "signing_complete"
      flash[:notice] = "Thanks! Successfully signed"
      render :text => utility.breakout_path(some_path), content_type: 'text/html'
    else
      flash[:notice] = "You chose not to sign the document."
      render :text => utility.breakout_path(some_other_path), content_type: 'text/html'
    end
  end
    
  def show

  end 


   private
    def docusign_params
      params.require(:docusign).permit(:envelopeId, :uri, :statusDateTime, :status)
    end
end
